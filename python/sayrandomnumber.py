# Copyright (c) 2009 - 2015 Tropo, now part of Cisco
# Released under the MIT license. See the file LICENSE
# for the complete license

# --------------------------------------------
# python app that says a random number between 1 and 100
# --------------------------------------------

from random import *

# The arguments to 'randint' define the start and end of the range. 

number = randint(1,100)

answer()

say("Hello. Your magic number today is %s. Goodbye." % number)

hangup()
