<?php
// -----------
// redirect
// -----------

if ($currentCall.callerID == "4075551111") 
	{
	answer();
	say("Hello, world!");
	hangup();
	}
 else
    redirect( "14129272341");
?>