<?php
// -----------
// reject based on callerid
// -----------

if ($currentCall->callerID == "4075551111") 
    {
	answer();
	say("Hello world!");
	hangup();
    }
 else
    reject();
?>