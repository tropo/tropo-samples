<?php
/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

$dice6 = rand(1,6);
$dice20 = rand(1,20);
$coin = rand(1,2);
$rps = rand(1,3);

function heads_tails() {
	if($coin == 1) {
		return "You got heads.";
	} else {
		return "You got tails.";
	}
}

$ht_var = heads_tails();

function rock_paper_scissors() {
	if($rps == 1) {
		return "You got rock.";
	} elseif ($rps == 2){
		return "You got paper.";
	} else {
		return "You got scissors.";
	}
}

$rps_var = rock_paper_scissors();

function the_ask() {
	ask("Welcome to the chance facilitator.  Select 1 for six sided dice, 2 for twenty sided dice, 3 for a coin flip, 4 for rock paper scissors.", array(
        "choices" => "1(one, 1), 2(two, 2), 3(three, 3), 4(four, 4)",
        "timeout" => 60.0,
        "attempts" => 3,
        "onChoice" => "choiceFCN",
        "onBadChoice" => "badChoiceFCN"
        )
    );
}

function choiceFCN($event) {
    say("You chose " . $event->value . ".");
	    if ($event->value == "1") {
		    say("You rolled a " . (string)$dice6 . ".");
		} else if ($event->value == "2") {
			say("You rolled a " . (string)$dice20 . ".");
		} else if ($event->value == "3") {
			say($ht_var);
		} else {
			say($rps_var);
		}
}

function badChoiceFCN($event) {
    say("I'm sorry,  I didn't understand that. Please try again.");
}

if($currentCall->initialText !=null) {
	ask("", array("choices" => "[ANY]"));
	the_ask();
} else {
	the_ask();
}

?>