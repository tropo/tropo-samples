# --------------------------------------------
# python app that says a random number between 1 and 100
# Created by Dan York
# Feb 24, 2008
# See http://www.tropo.com for more info
# --------------------------------------------

from random import *

# The arguments to 'randint' define the start and end of the range. 

number = randint(1,100)

answer()

say("Hello. Your magic number today is %s. Goodbye." % number)

hangup()
