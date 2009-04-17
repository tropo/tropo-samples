<?php
// --------------------------------------------
// Example of creating outgoing calls
// See http://www.tropo.com for more info
// --------------------------------------------
// 
// If this script is called via HTTP, the initial "answer();" can be
// removed.

answer();
event = call("sip:14076463131@10.6.63.201",
      array (
      "answerOnMedia" => false,
      "callerID"      => "tel:+666666666666",
      "timeout"      => 12.123,
      "onAnswer"      => create_function( '$event', _log("***** Answered from " + event.value.calleeId") ),
      "onError"      => create_function( '$event', _log("***** Error ") ),
      "onTimeout"    => create_function( '$event', _log("***** Timeout ") ),
      "onCallFailure" => create_function( '$event', log("***** Call Failed ") ),
      ) );


?>
