/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

var dice6=Math.floor((6-0)*Math.random()) + 1;
var dice20=Math.floor((20-0)*Math.random()) + 1;
var coin=Math.floor((2-0)*Math.random()) + 1;
var rps=Math.floor((3-0)*Math.random()) + 1;

var def_vox = "simon";

function heads_tails() {
	if (coin == 1) {
		return "You got heads.";
	} else {
	    return "You got tails.";
	}
}

var ht_var = heads_tails();

function rock_paper_scissors() {
	if (rps == 1) {
		return "You got rock.";
	} else if (rps == 2) {
	    return "You got paper.";
	} else {
		return "You got scissors.";
	}
}

var rps_var = rock_paper_scissors();

function the_ask() {
    ask("Welcome to the chance facilitator.  Select 1 for six sided dice, 2 for twenty sided dice, 3 for a coin flip, 4 for rock paper scissors.", {
        choices: "1(one, 1), 2(two, 2), 3(three, 3), 4(four, 4)",
        timeout: 60.0,
        attempts: 3,
        onBadChoice: function(event) {
            say("I’m sorry,  I didn’t understand that. Please try again.");
        },
        onChoice: function(event) {
            say("You chose " + event.value + ".");
                if (event.value == "1") {
                    say("You rolled a " + dice6 + ".");
                } else if (event.value == "2") {
                    say("You rolled a " + dice20 + ".");
                } else if (event.value == "3") {
                    say(ht_var);
                } else {
	                say(rps_var);
                } 
            }
        });
}

if(currentCall.initialText !== null)
    {
    ask("", { choices:"[ANY]" });
    the_ask();
    }
else
    {
    the_ask();
    }