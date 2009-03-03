<?php

answer();

// Set initial state
$simon = array();
$win = true;
$inchar = "";

// keep going up to a pattern of 20 digits
while ( ($win == true) && (count($simon) <= 20) ) {

	// add another character to the pattern and read the pattern to the caller
	$simon[] = rand(0,9);
	say("Simon says");
	foreach($simon as $s) {
		say($s);
	}
	
	// now get the user input
	say("you say");
	$i = 0;
	while ($i < count($simon)) {
		$event=ask("", array("choices"  => "1,2,3,4,5,6,7,8,9,0"));
		if ($event->name=='choice') {
			$inchar = $event->value;
		}  
		
		// read back each character of user input
		say($inchar);
		
		// if the user entered the incorrect character then we're done.
		if ($inchar != $simon[$i]) {
			$win = null;
			say("Sorry, that's not right.  goodbye.");
			hangup();
			break;
		}
		
		$i++;
	}  // while
	
	// if the user won that round then see if we need to continue
	if ($win == true) {
		say("Good Job!");
		wait(3);
		if (count(simon) > 20) {
		  say("You beat simon!");
		  hangup();
		} else {
		  say("Next round");
		}  // if
	}  // if

}  // while
?>