<?php
$fsUser = 'you@example.com';
$fsPass = 'your-4sq-pass';

require 'TropoClasses.php';

$voice = 'allison';
// set the base URL for the app
$base = (!empty($_SERVER['HTTPS'])) ? "https://" : "http://";
$base .= $_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];

$tropo = new Tropo();
// set a default action
$action =  (isset($_GET['event'])) ? $_GET['event'] : '/';

if ($action == '/') {
  // This is a new session, not an event.
  
  // Set up the event that fires when the next response is sent from Tropo
  $tropo->on(array('event'=>'continue', 'next' => $base .'?event=checkin'));
  $tropo->say('Welcome to the Four Square check in I V R.', array('voice' => $voice));

  // Get last FS checkin
  $history = getapi('history',null,1);
  if (!is_array($history['checkins'])) {
    // Since we have no data, foursquare API must be having issues. Hang up.
    $tropo->say('Could not reach the Four Square API. Try again later.', array('voice' => $voice));
    print $tropo;
    die();
  }
  // What is the geolocation of my last checkin?
  $lat = $history['checkins'][0]['venue']['geolat'];
  $long = $history['checkins'][0]['venue']['geolong'];

  // Find venues nearby where I've checked in recently.
  $nearby = getapi('venues',array('geolat' => $lat, 'geolong' => $long),9);
  
  $dtmf = 1;
  $venues = array();
  // Look over all the venues nearby and create a question and grammar
  foreach ($nearby['groups'] as $group) {
    foreach ($group['venues'] as $venue) {
      // Pressing 10 is hard. Make it zero instead
      $dtmf = ($dtmf == 10) ? 0 : $dtmf;
      // Venue name, press number
      $say .= $venue['name'] .', press ' . $dtmf .'. ';
      // Build a grammar with the venue ID as the concept and the name and 
      // dtmf tone as options. Strip certain characters from venue names that
      // might cause the grammar engine to choke
      $choices .= "{$venue['id']} (". cleangrammar($venue['name']) .", $dtmf), ";
      $dtmf++;
    }
  }

  // We allow the caller to say the name of the venue with voice recognition or to press
  // or say the number of the venue.
  $tropo->say('Speak the name of the venue or press it\'s number.', array('voice' => $voice));
  $tropo->ask($say, array(
    'voice' => $voice, 
    'choices'=>$choices,
    'required'=>true,
    'attempts'=>3,
    'timeout'=>30,
    'bargein'=> true
    ));
}


if ($action == 'checkin') {
  // This is the result of the question being answered
  $result = new Result();
  $vid = $result->getValue();
  if ($vid) {
    // If we have a value back, it's because the input matched.
    // So take that venue ID and check in here.
    $checkin = getapi('checkin', array('vid'=>$vid),1,'POST'); 
    // We're going to speak the foursquare result message to them 
    $message = $checkin['checkin']['message'];
    // Is there a new Mayor? if so, let them know!
    if ($checkin['checkin']['mayor']['type'] != 'nochange') {
      $message .= ' '. $checkin['checkin']['mayor']['message'];
    }
    $tropo->say($message, array('voice' => $voice));
  } else {
    // No value came back, so there was no match. Let the user know we
    // can't help.
    // An interesting enhancement here would be to look for a lack of matches
    // try again. Some better error handling than just hanging up would be
    // nice/
    $tropo->say('Something went wrong. I do not know where to check you in.', array('voice' => $voice));
  }
  $tropo->say('Good bye!', array('voice' => $voice));
}

// Spit out the JSON. Could have also used $tropo->renderJSON here
// but that sets a content-type header, so I can't see my json in 
// the browser with it.
print $tropo;


function getapi($api, $data=array(), $limit=20,$method='GET') {
  global $fsUser;
  global $fsPass;
  $params = '';
  // if this is an api that requires GET, build a query string
  if ($method == 'GET' && is_array($data)) {
    foreach ($data as $key=>$value) {
      $params .= '&'. $key . '=' . $value;
    }
  }
  // Use curl to hit the Foursquare API. Use your username and password
  // to authenticate all calls to the API
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, 'http://api.foursquare.com/v1/'.$api.'.json?l='.$limit . $params);
  curl_setopt($ch, CURLOPT_USERPWD, $fsUser .':'. $fsPass);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  // instead this requires POST so add the fields to the POST body
  if ($method == 'POST' && is_array($data)) {
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
  }
  $json = curl_exec($ch);
  curl_close($ch);
  // Turn the Foursquare response into an array.
  return json_decode($json, TRUE);
}

function cleangrammar($text) {
  $text = str_replace('/',' ', $text);
  $text = str_replace('.','', $text);
  $text = str_replace('&',' and ', $text);
  $text = str_replace(',',' ', $text);
  return $text;
}
?>