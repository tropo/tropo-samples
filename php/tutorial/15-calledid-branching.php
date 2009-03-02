<?php
// -----------
// Changing behavior based on number called
// -----------

answer();

if ($currentCall->calledId == "4075551111") say( "Hello Andrew.");
if ($currentCall->calledId == "4075552222") say( "Hello Brian. ");

hangup();
?>