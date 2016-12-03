<?php

/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

error_reporting(0);

require 'tropo-webapi-php/tropo.class.php';
require 'lib/limonade.php';

// This is a helper method, used when the caller initially sends in a valid input over the text channel.
function valid_text(&$tropo, $initial_text) {
	
// Welcome prompt.
$tropo->ask("Welcome to the Tropo PHP example for $network");

	// Provide a prompt based on the the initial_text value
	if ($initial_text == "1") 
		{$tropo->say("You picked Lord of the Rings.  Did you know Gandalf is also Magneto?  Weird.");
		}
	if ($initial_text == "2") 
		{$tropo->say("You picked the original Star Wars.  I hear Leonard Nimoy was awesome in those.");
		}
	if ($initial_text == "3") 
		{$tropo->say("You picked the Star Wars prequels.  Stop calling this number, Mr. Lucas, we know it's you.");
		}
	if ($initial_text == "4") 
		{$tropo->say("You picked the Matrix. Dude, whoa.");
		}
		
	// Tell Tropo what to do next. This redirects to the instructions under dispatch_post('/hangup', 'app_hangup').
	$tropo->on(array("event" => "continue", "next" => "testapp.php?uri=hangup"));

	// Tell Tropo what to do if there's an error. This redirects to the instructions under dispatch_post('/incomplete', 'app_incomplete').
	$tropo->on(array("event" => "incomplete", "next" => "testapp.php?uri=incomplete"));

}

dispatch_post('/start', 'app_start');
function app_start() {

	// Create a new instance of the Session object, and get the channel information.
	$session = new Session();
	$from_info = $session->getFrom();
	$network = $from_info['channel'];	

    // Create a new instance of the Tropo object.
	$tropo = new Tropo();
	
	 // See if any text was sent with session start.
	$initial_text = $session->getInitialText();

	// If the initial text is a zip code, skip the input collection and go right to results.
	if(strlen($initial_text) == 1 && is_numeric($initial_text)) {
	valid_text($tropo, $initial_text);
	}
	
	else {

	// Welcome prompt.
	$tropo->say("Welcome to the Tropo PHP example for $network");

	// Set up options for input.
	$options = array("attempts" => 3, "bargein" => true, "choices" => "1,2,3,4", "mode" => "dtmf", "name" => "movie", "timeout" => 30);

	// Ask the caller for input, pass in options.
	$tropo->ask("Which of these trilogies do you like the best?  Press 1 to vote for Lord of the Rings, press 2 for the original Star Wars, 3 for the Star Wars prequels, or press 4 for the Matrix", $options);

	// Tell Tropo what to do when the user has entered input, or if there's a problem. This redirects to the instructions under dispatch_post('/choice', 'app_choice') or dispatch_post('/incomplete', 'app_incomplete').
	$tropo->on(array("event" => "continue", "next" => "testapp.php?uri=choice", "say" => "Please hold."));
	$tropo->on(array("event" => "incomplete", "next" => "testapp.php?uri=incomplete"));
	
	}

	// Render the JSON for the Tropo WebAPI to consume.
	return $tropo->RenderJson();

}

dispatch_post('/choice', 'app_choice');
function app_choice() {
	
	// Accessing the result object
	$result = new Result();
	$choice = $result->getValue();
	
	// Create a new instance of the Tropo object.
	$tropo = new Tropo();
	
	// Provide a prompt based on the value
	if ($choice == "1") 
		{$tropo->say("You picked Lord of the Rings.  Did you know Gandalf is also Mag knee toe?  Weird.");
		}
	if ($choice == "2") 
		{$tropo->say("You picked the original Star Wars.  I hear Leonard Nimoy was awe some in those.");
		}
	if ($choice == "3") 
		{$tropo->say("You picked the Star Wars prequels.  Stop calling this number, Mr. Lucas, we know it's you.");
		}
	if ($choice == "4") 
		{$tropo->say("You picked the Matrix. Dude, woe.");
		}

	// Tell Tropo what to do next. This redirects to the instructions under dispatch_post('/hangup', 'app_hangup').
	$tropo->on(array("event" => "continue", "next" => "testapp.php?uri=hangup"));
	
	// Tell Tropo what to do if there's an problem, like a timeout. This redirects to the instructions under dispatch_post('/incomplete', 'app_incomplete').
	$tropo->on(array("event" => "incomplete", "next" => "testapp.php?uri=incomplete"));
	
	// Render the JSON for the Tropo WebAPI to consume.
	return $tropo->RenderJson();
}

dispatch_post('/hangup', 'app_hangup');
function app_hangup() {
	
	$tropo = new Tropo();
	
	$tropo->say("Thanks for voting!");
	$tropo->hangup;
	return $tropo->RenderJson();
}

dispatch_post('/incomplete', 'app_incomplete');
function app_error() {
	
	$tropo = new Tropo();
	
	$tropo->say("Something has gone wrong, please call back.");
	$tropo->hangup;
	return $tropo->RenderJson();
}

// Run this sucker!
run();
 
?>    
