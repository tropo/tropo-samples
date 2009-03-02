# Random quiz - by Dan York, Feb 24, 2009

# THIS CODE IS BROKEN - and in fact goes into an infinite loop in Tropo
# It is provided here more as an example of the type of thing that *could*
# be done (by a better programmer than me!).  I'm guessing that I'm not
# using "guess.value" correctly.  I need to do some more debugging.

from random import *

target = randint(1,10)
log("****** Target is +> %s " % target)

match = 0

answer()

say("I have chosen a number between 1 and 10. Please guess what it is.")

while (match != 1):
   guess=ask("What is your guess?", {'choices':"1,2,3,4,5,6,7,8,9,10"})
   log("**** guess is --> %s" % guess.value)

   if (guess.value == target):
        say("Great job! You guessed correctly")
        #could then ask to play again
        match = 1
   else:
        say("Sorry, please guess again")

say("Thank you for playing this game")
hangup()
