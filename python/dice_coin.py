# Copyright (c) 2009 - 2015 Tropo, now part of Cisco
# Released under the MIT license. See the file LICENSE
# for the complete license

import random

dice6 = random.randint(1,6)
dice20 = random.randint(1,20)
coin = random.randint(1,2)
rps = random.randint(1,3)

def heads_tails() :
    if (coin == 1) :
        return "You got heads."
    else :
        return "You got tails."

ht_var = heads_tails()

def rock_paper_scissors() :
    if (rps == 1) :
        return "You got rock."
    elif (rps == 2) :
        return "You got paper."
    else :
        return "You got scissors."

rps_var = rock_paper_scissors()

def choiceFCN(event):
    say("You chose " + event.value + ".")
    if (event.value == "1") :
        say("You rolled a " + str(dice6) + ".")
    elif (event.value == "2") :
        say("You rolled a " + str(dice20) + ".")
    elif (event.value == "3") :
        say(ht_var)
    else :
	    say(rps_var)
 
def badChoiceFCN(event):
    say("I'm sorry,  I didn't understand that. Please try again.")

def the_ask() :
    ask("Welcome to the chance facilitator.  Select 1 for six sided dice, 2 for twenty sided dice, 3 for a coin flip, 4 for rock paper scissors.", {
        "choices":"1(one, 1), 2(two, 2), 3(three, 3), 4(four, 4)",
        "timeout":60.0,
        "attempts":3,
        "onChoice": choiceFCN,
        "onBadChoice": badChoiceFCN
    })

if(currentCall.initialText is not None) :
    ask("", {"choices":"[ANY]"})
    the_ask()
else :
    the_ask()