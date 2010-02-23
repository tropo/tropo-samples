<?php
answer(30);

$channel = $currentCall->channel;
$network = $currentCall->network;

if ($channel == 'TEXT') {
  $initialPrompt = 'What is your zip code?';
  $timeout = 300;
  $repeat = 0;
  // If they start the message with 5 digits, don't ask for their zip code.
  if (preg_match('/\d{5}/',$currentCall->initialText)) {
    $initialPrompt = '';
  }
} else {
  $initialPrompt = 'Hello. What zip code are you calling from?';
  $timeout = 30;
  $repeat = 3;
  // On voice, pause a moment before speaking
  sleep(2);
}
$zip = '';

$event = prompt($initialPrompt,
            			array (
            			  "choices" => '[5 DIGITS]',
            			  "timeout" => 30,
            			  "repeat" => 3,
            			  "onChoice" => create_function('$event','onzip($event->value)'),
            			) 
            		 );  
hangup();

function categories($channel) {
  // If this is a text channel, we don't need speech recognition
  // so accept any input using the grammar [ANY]
  if ($channel == 'TEXT') {
    return '[ANY]';
  }
  // Otherwise, use a restaurant-focused grammar.
  $categories = 'Afghan, American, Asian, Barbeque(Barbeque, BBQ), Brazilian, Breakfast, Brunch, British, Buffets(Buffets, Buffet), Burgers(Burgers,Burger), Caribbean, Wings(Wings, Chicken Wings, Hot Wings, Buffalo Wings), Chinese, Creperies(Creperies, Crepes), Deli(Deli, Delis), Diners(Diners, Dinner, Greasy Spoon), Ethiopian, Fast Food, Filipino, French, German, Greek, Hawaiian, Hot Dogs(Hot Dogs, Sausages, Dogs), Indian, Italian, Japanese, Korean, Latin American, Mediterranean, Mexican, Middle Eastern, Mongolian, Moroccan, Pakistani, Persian(Iranian, Persian), Pizza, Russian, Sandwiches, Seafood, Soul Food(Soul Food, Soul), Southern, Steakhouses(Steakhouses, Steak, Steakhouse), Sushi(Sushi, Sushi Bar, Sushi Bars, Sashimi), Taiwanese, Tapas, Tex Mex, Thai, Vegan, Vegetarian, Vietnamese, Bagels, Bakeries(Bakery, Bakeries), Beer, Wine, Breweries(Breweries, Brewery), Coffee, Tea, Convenience Store, Desserts, Donuts, Farmers Market, Grocery, Ice Cream, Frozen Yogurt(Frozen Yogurt, Yogurt), Juice Bars, Smoothies(Smoothie, Smoothies), Specialty Food, Wineries(Wine, Wineries, Winery)';
  return $categories;
}

function fetchYahoo($category, $zip, $count = 5) {  
  $url = 'http://local.yahooapis.com/LocalSearchService/V3/localSearch?appid=TropoDemo&query='. $category .'&zip='. $zip .'&results=' . $count . '&output=php';
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, $url);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  if (curl_error($ch)) {
    say("ERROR ". curl_error($ch));
    die();
  }
  $output = unserialize(curl_exec($ch));
  curl_close($ch);
  return $output['ResultSet']['Result'];
}

function onCategory($category) {
  global $zip;
  global $network;
  $count = 5;
  if ($network == 'SMS') {
    $count == 1;
  }
  $resultset = fetchYahoo($category, $zip, $count);
  print_results($resultset, $channel, $network);
}

function onzip($zipcode) {
  global $zip;
  $zip = $zipcode;
  $categories = categories($channel);
  if ($channel == 'TEXT') {
    $sayZip = $zip;
  } else {
    $sayZip = "<say-as interpret-as='vxml:digits'>$zip</say-as>";
  }
  $event = prompt("<speak>What are you looking for in $sayZip?</speak>",
                			array (
                			  "choices" => $categories,
                			  "onChoice" => create_function('$event','onCategory($event->value);'),
                			) 
  		            );
}

function print_results($results, $channel, $network) {
  if (!is_array($results)) {
    say('No results found. Try another search.');
    return;
  }
  if ($channel == 'TEXT') {
    if ($network == 'SMS') {
      return print_results_sms($results);
    } else {
      return print_results_im($results);      
    }
  } else {
    return print_results_voice($results);
  }
}

function print_results_im($results) {
  foreach ($results as $location) {
    // Workaround for Tropo bug. Tropo tries to play URLs as audio instead
    // of printing them, so strip http:// off and this won't happen
    $location['ClickUrl'] = str_replace('http://', '', $location['ClickUrl']);
    $ret = $location['Title'] . " - ";
    $ret .= $location['Address'] . ', '. $location['City'] . " - ";
    $ret .= $location['Phone'] . " - ";
    $ret .= $location['ClickUrl'];
    // Individual say() to get individual messages
    say($ret);
    
  }
}

function print_results_sms($results) {
  foreach ($results as $location) {
    $ret = $location['Title'] . " - ";
    $ret .= $location['Address'] . " - ";
    $ret .= $location['Phone'];
    // Individual say() to get individual messages
    say($ret);
  }
}


function print_results_voice($results) {
  $i = 1;
  foreach ($results as $location) {
    $title = str_replace(' & ', ' and ', $location['Title']);
    $choices .= 'press '. $i .' for '. $title .', ';
    $number[$i] = $location['Phone'];
    $name[$i] = $title;
    $i++;
  }
  $event = prompt($choices,
  			array (
  			  "choices" => '1,2,3,4,5',
  			) 
  		 );
  if ($event->name == 'choice') {
    say('Connecting you to '. $name[$event->value] .' at '. $number[$event->value] .'. Please hold.');
    $dial = str_replace('(','',$number[$event->value]);
    $dial = str_replace(')','',$dial);
    $dial = str_replace(' ','',$dial);
    $dial = str_replace('-','',$dial);
    $dial = str_replace('+','',$dial);
    transfer(preg_replace('[^0-9]','',$number[$event->value]));
  }
}
?>