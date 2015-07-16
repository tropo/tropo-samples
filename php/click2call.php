<?php
/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */


// This script requires tropo-rest.class.php
// from http://github.com/tropo/tropo-webapi-php
// Download it and place in the same directory as 
// this script.

// Create a Tropo Scripting application and enter
// the application URL as 
// <path-to-this-script>?action=tropo&tropo-engine=php
// For example, if you upload this file as 
// http://example.com/click2call.php then your 
// Tropo applicaiton URL is 
// http://example.com/click2call.php?action=tropo&tropo-engine=php

// Configure this with the phone number
// that should be called when the user clicks
// (this is probably your phone number)
$number = '+14155551212';

// Your email address. Voicemails will be sent here
$email = 'you@example.com';

// Your API token from Tropo
$token = '';

// END configuration
// **********************************************************

$action = array_key_exists('action', $_GET) ? $_GET['action'] : '';
switch ($action) {
  case 'tropo':
    print getTropo();
    break;
  case 'record':
    mail_attachment($_FILES['filename']['tmp_name'], '', $email, $email, '', '', 'Voicemail from Tropo', 'You have received a new voicemail from your Tropo Click to Call.');
    break;
  default:
    print form($token);
    break;
}

// Print out the code that Tropo will use to run this app.
function printTropo() {
  $post = getself() . '?action=record';
  $code = <<<EOD
  <?php
  call('+' . \$from);
  sleep(2); // Pause a moment after they answer.
  say('One moment, connecting you now.');
  transfer($number, array(
    'playvalue' => 'https://raw.githubusercontent.com/tropo/pre-recorded_audio_library/master/Telephone/ring.wav',
    'playrepeat' => '10',
    'onTimeout' => 'handleTimeout'
    ));

  function handleTimeout() {
    record('Sorry, but I am not available right now. Please leave a message.', array(
      'beep' => true,
      'maxTime' => 45,
      'recordURI' => $post
      ))
  }
  ?>
EOD;
  return $code;
}

function form($token) {
  $phone = array_key_exists('phone', $_POST) ? $_POST['phone'] : '';
  $form = <<<EOD
    <form method="post">
      <p><label for="number">Your phone number:</label> +<input type="text" id="number" name="phone" value="$phone"/><br/>Include country code (ex: 1 415 555 1212)</p>
      <p><label for="submit"></label><input type="submit" id="submit" name="submit" value="Call Me"/></p>
    </form>
EOD;
  if (!empty($_POST['phone'])) {
    include 'tropo-rest.class.php';
    $from = preg_replace("/[^0-9]/","",$_POST['phone']);
    $session = new SessionAPI();
    try {
      $session->createSession($token, array('from' => $from));
      print '<p>Calling you now.</p>';
    } catch (Exception $e) {
      print $e->getMessage();
    }
  }
  print $form;
}

// Simple function to get the full URL of the current script.
function getself() {
 $pageURL = 'http';
 $url = ($_SERVER["HTTPS"] == "on") ? 'https' : 'http';
 $url .= "://" . $_SERVER["SERVER_NAME"];
 $url .= ($_SERVER["SERVER_PORT"] != "80") ? ':'. $_SERVER["SERVER_PORT"] : '';
 $url .= $_SERVER["REQUEST_URI"];
 return $url;
}

// From http://www.finalwebsites.com/forums/topic/php-e-mail-attachment-script
function mail_attachment($filename, $path, $mailto, $from_mail, $from_name, $replyto, $subject, $message) {
    $file = $path.$filename;
    $file_size = filesize($file);
    $handle = fopen($file, "r");
    $content = fread($handle, $file_size);
    fclose($handle);
    $content = chunk_split(base64_encode($content));
    $uid = md5(uniqid(time()));
    $name = basename($file);
    $header = "From: ".$from_name." <".$from_mail.">\r\n";
    $header .= "Reply-To: ".$replyto."\r\n";
    $header .= "MIME-Version: 1.0\r\n";
    $header .= "Content-Type: multipart/mixed; boundary=\"".$uid."\"\r\n\r\n";
    $header .= "This is a multi-part message in MIME format.\r\n";
    $header .= "--".$uid."\r\n";
    $header .= "Content-type:text/plain; charset=iso-8859-1\r\n";
    $header .= "Content-Transfer-Encoding: 7bit\r\n\r\n";
    $header .= $message."\r\n\r\n";
    $header .= "--".$uid."\r\n";
    $header .= "Content-Type: application/octet-stream; name=\"".$filename."\"\r\n"; // use different content types here
    $header .= "Content-Transfer-Encoding: base64\r\n";
    $header .= "Content-Disposition: attachment; filename=\"".$filename."\"\r\n\r\n";
    $header .= $content."\r\n\r\n";
    $header .= "--".$uid."--";
    if (mail($mailto, $subject, "", $header)) {
        echo "mail send ... OK"; // or use booleans here
    } else {
        echo "mail send ... ERROR!";
    }
}


?>