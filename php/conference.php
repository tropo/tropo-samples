<?php
/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

// See http://bit.ly/confTutorial for a tutorial with this code.

// An array of conference IDs and phone numbers to alert.
// If a conference ID is used that has a phone number attached,
// when someone joins or leaves that conference, the attached phone
// number will get an SMS alerting them.
$pins = array();
$pins['1337'] = '14075551212';
$pins['2600'] = '19255556789';
$pins['1234'] = ''; // won't alert

// If set to true, only known Conference IDs will be accepted
$require_pin = false;
answer();

$voice = 'kate';

while ($currentCall->isActive()) {
  $response = ask('Enter your conference ID, followed by the pound key.', array(
    'terminator' => '#',
    'choices' => '[1-10 DIGITS]',
    'timeout' => '3',
    'mode' => 'dtmf',
    'voice' => $voice
    ));
  switch($response->name) {
    case 'choice':
      if ($require_pin && !array_key_exists($response->value, $pins)) {
        // This conference only allows specific conference IDs, and the one
        // entered isn't on the list.
        say('Sorry, that is not a valid conference ID.', array('voice' => $voice));
        break;
      }
      if (array_key_exists($response->value, $pins) && !empty($pins[$response->value])) {
        // Send an alert that someone has entered the conference
        message($currentCall->callerID . ' has entered conference ' . $response->value, array('to' => $pins[$response->value], 'network' => 'SMS'));
      }
      say('<speak>Conference ID <say-as interpret-as="vxml:digits">' . $response->value . '</say-as> accepted.</speak>', array('voice' => $voice));
      say('You will now be placed into the conference. Please announce yourself. To exit the conference without disconnecting, press pound.', array('voice' => $voice));
      conference($response->value, array('terminator' => '#'));
      say('You have left the conference.', array('voice' => $voice));
      if (array_key_exists($response->value, $pins) && !empty($pins[$response->value])) {
        // Send an alert that someone has entered the conference
        message($currentCall->callerID . ' has left conference ' . $response->value, array('to' => $pins[$response->value], 'network' => 'SMS'));
      }
      // Pause a moment before asking for another conference.
      sleep(1);
      break;
    case 'badChoice':
      say('Sorry, that is not a valid conference ID.', array('voice' => $voice));
      break;
    case 'silenceTimeout':
    case 'timeout':
      say('Sorry, I didn\'t hear anything.', array('voice' => $voice));
      break;
  }
}
?>