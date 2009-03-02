# --------------------------------------------
# A Monty Python quote server (in python)
# See http://www.tropo.com for more info
# --------------------------------------------

import re

class getSearchTerm :
        def singleMatch( self, matchTerm, listCandidates ) :
                reCompiled = re.compile( matchTerm )
                matches = 0
                for oneCandidate in listCandidates :
                        if re.match( reCompiled, oneCandidate.lower() ) :
                                matches = matches + 1
                                lastMatch = oneCandidate
                if matches == 1 :
                        return lastMatch
                elif matches == 0 :
                        return "No match"
                else :
                        return "Multiple matches"

listQuotes = [ 'Always look on the bright side of life.',
               'It was a fantastic success. Over 60000 times more powerful than Britains great pre-war joke, and one which Hitler just couldnt match.',
               'Your highness, when I said that you are like a stream of bats piss, I only mean that you shine out like a shaft of gold when all around it is dark',
               'I dont wanna talk to you no more, you empty headed animal food trough wiper! I fart in your general direction!',
               'My philosophy, like color television, is all there in black and white',
               'Strange women lying in ponds distributing swords is no basis for a system of government!',
               'Oh but you cant expect to wield supreme executive power just because some watery tart threw a sword at you!',
               'She turned me into a newt!   A newt?   I got better...',
               'Its funny, isnt it? How your best friend can just blow up like that?',
               'We are no longer the knights who say nee! We are now the knights who say ekki-ekki-ekki-pitang-zoom-boing!',
               'Nudge, nudge, wink, wink. Know what I mean?',
               'And the Lord spake, saying, First shalt thou take out the Holy Pin. Then shalt thou count to three, no more, no less. Three shall be the number thou shalt count, and the number of the counting shall be three. Four shalt thou not count, neither count thou two, excepting that thou then proceed to three. Five is right out.',
               'Now stand aside, worthy adversary.  Tis but a scratch.  A scratch? Your arms off!  No, it isn’t.  Well, whats that, then?  Ive had worse.',
               'Look, you stupid bastard. Youve got no arms left.   Yes, I have.   Look!   Just a flesh wound.',
               'What? Ridden on a horse?   Yes      Youre using coconuts!      What?       Youve got two empty halves of coconuts and youre banging them together!     So?',
               'Oh! Come and see the violence inherent in the system! Help, help! Im being repressed!',
               'Our chief weapon is surprise...surprise and fear...fear and surprise.... Our two weapons are fear and surprise...and ruthless efficiency.... Our *three* weapons are fear, surprise, and ruthless efficiency...and an almost fanatical devotion to the Pope.... Our *four*...no... *Amongst* our weapons.... Amongst our weaponry...are such elements as fear, surprise.... Ill come in again.',
               'What? A swallow carrying a coconut?   It could grip it by the husk!   Its not a question of where he grips it! Its a simple question of weight ratios! A five ounce bird could not carry a one pound coconut.',
               'O Lord, bless this thy hand grenade, that with it thou mayst blow thine enemies to tiny bits, in thy mercy',
               'No, no. What else floats in water?   Bread. Apples.  Very small rocks.  Cider.  Gravy.  Cherries.  Mud.  Churches.  Led! Led!  A Duck.  Exactly. So, logically...  If she weighed the same as a duck... shes made of wood.   And therefore... ...A witch! ',
               'First you must find ... another shrubbery!  Then, when you have found the shrubbery, you must place it here, beside this shrubbery, only slightly higher so you get a two layer effect with a little path running down the middle. (A path! A path!) Then, you must cut down the mightiest tree in the forrest... with... a herring!' ]

answer()

say( "Welcome to the Tropo Monty Python quote server (in python)" )

searchDigits = ""

def addDigit( theDigit, allDigits ) :
        if theDigit.isdigit() :
                allDigits = allDigits + theDigit
                return allDigits
        return ''

def digitsToRegEx( someDigits ) :
        reAssembled = '.*'
        for oneDigit in someDigits :
                if oneDigit == '2' :
                        reAssembled = reAssembled + '[abc]'
                elif oneDigit == '3' :
                        reAssembled = reAssembled + '[def]'
                elif oneDigit == '4' :
                        reAssembled = reAssembled + '[ghi]'
                elif oneDigit == '5' :
                        reAssembled = reAssembled + '[jkl]'
                elif oneDigit == '6' :
                        reAssembled = reAssembled + '[mno]'
                elif oneDigit == '7' :
                        reAssembled = reAssembled + '[pqrs]'
                elif oneDigit == '8' :
                        reAssembled = reAssembled + '[tuv]'
                elif oneDigit == '9' :
                        reAssembled = reAssembled + '[wxyz]'
                elif oneDigit == '0' :
                        reAssembled = reAssembled + '\W'
        reAssembled = reAssembled + '.*'
        return reAssembled

searchFor = getSearchTerm()

digit = '0'
def saveDigit( newDigit ) :
        global digit
        digit = newDigit

event = ask( "Start spelling with your number pad (zero for space)",
             { 'choices':"2,3,4,5,6,7,8,9,0,*", 'timeout':10 })

runs = 0
bExit = False
while ( runs < 10 ) and ( not bExit ) :
        if ( event.name == 'choice' ) and ( event.value == '*' ) :
                bExit = True
        elif event.name == 'choice' :
                searchDigits = addDigit( event.value, searchDigits )
                matchTerm = digitsToRegEx( searchDigits )
                matchRes = searchFor.singleMatch( matchTerm, listQuotes )
                if matchRes != "Multiple matches" :
                        if  matchRes == 'No match' :
                                say( matchRes + " for " + searchDigits )
                        else :
                                say( matchRes )
                        searchDigits = ''
                        runs = runs + 1
        elif event.name == 'timeout' :
                bExit = True

        if not bExit :
                event = ask( "", { 'choices':"2,3,4,5,6,7,8,9,0,*", 'timeout':10 })

say("goodbye")

hangup()
