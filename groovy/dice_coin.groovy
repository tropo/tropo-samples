/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

dice6=(Math.floor((6-0)*Math.random()) + 1) as Integer
dice20=(Math.floor((20-0)*Math.random()) + 1) as Integer
coin=(Math.floor((2-0)*Math.random()) + 1) as Integer
rps=(Math.floor((3-0)*Math.random()) + 1) as Integer

def heads_tails() {
	if (coin == 1) {
		return "You got heads."
	} else {
		return "You got tails."
	}
}

ht_var = heads_tails()

def rock_paper_scissors() {
	if (rps == 1) {
		return "You got rock."
	} else if (rps == 2) {
		return "You got paper."
	} else {
		return "You got scissors."
	}
}

rps_var = rock_paper_scissors()

def the_ask() {
	event = ask("Welcome to the chance facilitator.  Select 1 for six sided dice, 2 for twenty sided dice, 3 for a coin flip, 4 for rock paper scissors.", [
        attempts: 3,
        timeout:60,
        choices: "1(one, 1), 2(two, 2), 3(three, 3), 4(four, 4)",
        onChoice: { event->
            say("You chose " + event.value + ".")    
            if (event.value == "1") {
                say("You rolled a " + dice6 + ".")
             } else if (event.value == "2") {
                say("You rolled a " + dice20 + ".")
             } else if (event.value == "3") {
	            say(ht_var)
	         } else {
		        say(rps_var)
	         }
        },
        onBadChoice: { event->
            say("I'm sorry,  I didn't understand that. Please try again.")
        }
    ])
}

if(currentCall.initialText != null)
    {
    ask("", [choices:"[ANY]"])
    the_ask()
    }
else
    {
    the_ask()
    }