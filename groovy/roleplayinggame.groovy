// --------------------------------------------
// A simple role-playing game 
// (using some of the characters around the
//  Voxeo office)
// See http://www.tropo.com for more info
// --------------------------------------------

import java.util.Random;

answer()

Random generator = new Random()

def outcome = ["crushes", "mortally wounds", "eats ", "disembowels ", "steps on", "squashes"]
def areas = ["the office of the director of ninja affairs", "next to Engineering", "in the brake room", "at your desk", "in the bathroom"]
def places = ["nothing", "an empty coke can", "a fudge round","a spider web of cat five cables","an eye kia chair"]
def items = ["lantern","scroll","compass"]

def strEnemy
def strContinue = true

def getEnemy() { 
  Random generator = new Random()

  def size = ["diminutive", " ", "giant", "large", "enormous"]
  def colors = ["red", "green", "blue", "purple", "yellow", "green"]
  def beast = ["Feinberg", "Matt Henry", "Stephen Neesh", "Pop Tart", "Dan Polfer", "Rob Green", "Rob Patton"]

  strEnemySize = size[generator.nextInt(size.size())]
  strEnemyColor = colors[generator.nextInt(colors.size())]
  strEnemyType = beast[generator.nextInt(beast.size())]
  strEnemy = "${strEnemySize} ${strEnemyColor} ${strEnemyType}"

return strEnemy
}

say("Welcome to Vox ay oh. ")

int i = 0;

while (strContinue) 
{
if(i == 0) {
      strArea = areas[generator.nextInt(areas.size())]
      strThing = places[generator.nextInt(places.size())]
      i = 1
           }
      
      say("You are standing ${strArea}.")
      if((generator.nextInt(100) % 2) == 1) { 
          strEnemy = getEnemy()
          say("You are attacked by a ${strEnemy}.") 
                                            }
          
          
      

result=ask( "What do you want to do?", [choices:"attack,run,north,south,east,west,help,exit"] )

 if (result.name=='choice')
 {
       
	if (result.value=="attack" && strEnemy != null) { say("You attack.") 
	   strOutcome = generator.nextInt(100)
          if (strOutcome % 2 == 0) { say("You have slain the ${strEnemy}") }
            else { say("You charge with your Sharpie drawn but the ${strEnemy} ${outcome[generator.nextInt(outcome.size())]} you. Goodbye.") 
            hangup()  }
            
            strEnemy = null
            
            }
    else if (result.value=="attack" && strEnemy == null) { say("There is nothing to attack, dummy!") } 

	if (result.value=="run" && strEnemy != null ) { say( "You run." ) 
	   strOutcome = generator.nextInt(100)
          if (strOutcome % 2 == 0) { say("You have escaped from the ${strEnemy}") }
            else { say("You scramble to get away but the ${strEnemy} ${outcome[generator.nextInt(outcome.size())]} you. Goodbye.") 
             hangup() } 
             strEnemy = null
             i = 0
             }       
    else if (result.value=="run" && strEnemy == null) { 
             say("What are you running from?") 
             i = 0 } 
            
    if (result.value=="exit") { 
        if(strEnemy == null) { say("Goodbye, pansy") }
        else { say("You try to exit like a coward but the ${strEnemy} ${outcome[generator.nextInt(outcome.size())]} you. Better luck next time.") }
         strContinue = false
                            }
    if (result.value=="look") { say("You see ${strThing}.") }
    
    if (result.value=="help") { say("You can say look, north, south, east, west, attack, run or exit.") }
    
    if (result.value=="north" || result.value=="south" || result.value=="east" || result.value=="west") { 
        say("You walk ${result.value}")
        i = 0 
        }
        
  }
}

hangup()
