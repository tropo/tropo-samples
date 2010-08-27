<?php
// This array is in the format of
// tropo_number => transfer_to
$numbers = array(
    '9165551212' => '13105551212',
    '6505551313' => '12065551313',
  );
  
answer();
if (!array_key_exists($currentCall->calledID, $numbers)) {
  // This shouldn't be able to happen. But log it and hang up.
  _log('Error: Could not handle a call to '. $currentCall->calledId);
} else {
  $options = array(
      'playvalue' => 'http://example.com/ring.mp3',
    );
  transfer('tel:+' . $numbers[$currentCall->calledID], $options);
}
hangup();

?>