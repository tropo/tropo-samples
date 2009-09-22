<?php
// -----------
// redirect
// -----------

if ($currentCall->callerID == "4075551111") 
	{
	answer();
	say("Hello, world!");
	hangup();
	}
 else
    redirect( "tel:+14129272341");
?>