<?php
/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */


// An array of phone numbers that are part of the phone tree.
$members = array('2125551212', '4155551313');

if (!in_array($currentCall->callerID, $members)) {
  // The caller isn't a member of the phone tree.
  say('Sorry, only members of the group can send to this group.');
  hangup();
}

$done = FALSE;
while ($done == FALSE) {
  $recording = record('Reecord your message at the tone. Press pound when finished.', array('terminator' => '#'));
  // reset selection to 1 since this is a new recording.
  $selection = 1;
  while ($selection == 1) {
    $choice = ask('To listen to your message, press 1. To re reecord your message, press 2. To send your message, press 3.', array('choices' => '1,2,3', 'mode' => 'dtmf'));
    $selection = $choice->value;
    if ($selection == 1) {
      // Play the message, then reprompt.
      say($recording->value);
    } elseif ($selection == 3) {
      // Break out of the recording loop.
      $done = TRUE;
      continue 2;
    }
    // Pause a moment before replaying the prompt.
    sleep(1);
  }
}
// If we've gotten here, then it's time to send the message.
say("Sending your message now. Please wait.");

// If you don't provide a recordURI for the record() function, Tropo
// will hold your message until the session is over. Once you hangup
// the recording is deleted. Because of this, the sample application
// makes the caller wait on the line until the messages have all been
// delivered. In a real-world application, you would supply a 
// recordURI and store your message there, playing it to the phone
// tree without making the caller stay on the line.

// Loop over the members list and send the message.
foreach ($members as $to) {
  _log("Sending to " . $to);
  // Don't send to the person who recorded it.
  if ($to != $currentCall->callerID) {
    message('You have a message from the phone tree. ' . $recording->value, array('to' => '+1' . $to, 'callerID' => $currentCall->calledID));    
  }
}

say("All done. Goodbye.");
hangup();

?>