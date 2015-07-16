<?php
/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

event = call("sip:14076463131@10.6.63.201",
      array (
      "answerOnMedia" => false,
      "callerID"      => "tel:+666666666666",
      "timeout"      => 12.123,
      "onAnswer"      => create_function( '$event', _log("***** Answered from " + event.value.calleeId) ),
      "onError"      => create_function( '$event', _log("***** Error ") ),
      "onTimeout"    => create_function( '$event', _log("***** Timeout ") ),
      "onCallFailure" => create_function( '$event', log("***** Call Failed ") ),
      ) );


?>
