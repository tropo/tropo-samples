<?php

// -----------------
// Tutorial 18 - recording audio input
// -----------------

answer();

// record a message.  Play the beep, caller must speak within 10 seconds.  
// Allow 7 seconds of silence and up to 60 seconds of recording.

$result=record( "Hello.  Thanks for calling.  Leave your message at the beep.",
  				array( "beep" => true, "timeout" => 10, "silenceTimeout" => 7, "maxTime" => 60 ) );

_log("RECORDING RESULT name = " . $result->name . "||");
_log("                value = " . $result->value . "||");
_log("            recordURI = " . $result->recordURI . "||");

if( $result->name == 'record' ) 
{ 
	// record returns a URI pointing to the recorded audio...
	
	log( "result.recordURI = " . $result->recordURI );
	
	// we can then use that URI in a say command to play the recorded audio back...
	
	say( "you said " . $result->recordURI );
}

hangup();

?>