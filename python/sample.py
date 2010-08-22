# --------------------------------------
# Sample Tropo app
# See http://www.tropo.com for more info
# --------------------------------------

answer()

event=prompt("where are you heading?",
   {'repeat':3,'choices':"1st Floor (first, house wares, 1), 2nd Floor (second, bed and bath, 2), 3rd Floor (third, sporting goods, 3)", 'timeout':10.03456789, 
    'onChoice':lambda event :
      event.onChoice( "1st Floor", lambda : say("Your destination is 1st Floor" ) ) and 
      event.onChoice( "2nd Floor", lambda : say("Your destination is 2nd Floor" ) ) and 
      event.onChoice( "3rd Floor", lambda : say("Your destination is 3rd Floor" ) ) and  
      event.onBadChoice( lambda : say("I can not recognize you. Please input again. ") ),
    'onTimeout':lambda : say("wait input time out" ), 
    'onError':lambda : say("You have an error!" ),
    'onHangup':lambda : log(">>>>>>>>>>>>>>>>>>Disconnected by the peer!<<<<<<<<<<<<<<<<<"),
    'onEvent':lambda event : 
      event.onError( lambda : say("You have an error! " ) ) and
      event.onTimeout( lambda : say("wait input time out" ) ) and
      event.onHangup( lambda : log(">>>>>>>>>>>>>>>>>>>>Disconnected by the peer!<<<<<<<<<<<<<<<<<") ) and
      event.onChoice( "1st Floor", lambda : say("Your destination is 1st Floor" ) ) and 
      event.onChoice( "2nd Floor", lambda : say("Your destination is 2nd Floor" ) ) and 
      event.onChoice( "3rd Floor", lambda : say("Your destination is 3rd Floor" ) ) and  
      event.onBadChoice( lambda : say("I can not recognize you. Please input again. " ) )
  }
)

if event.name!="hangup":
  if event.value != None:
    say("run outer call back for event [" + event.name + "," + event.value + "]")
  else:
    say("run outer call back for event [" + event.name + "]")
  event.onError( lambda : say("You have an error! " ) )
  event.onChoice( "1st Floor", lambda : say("Your destination is 1st Floor" ) )
  event.onChoice( "2nd Floor", lambda : say("Your destination is 2nd Floor" ) )
  event.onChoice( "3rd Floor", lambda : say("Your destination is 3rd Floor" ) )
  event.onBadChoice( lambda : say("I can not recognize you" ) ) 
  say("Thanks for testing Python on the Tropo platform")
  hangup()
else:
  log(">>>>>>>>>>>>>>>Disconnected by the peer!<<<<<<<<<<<<<<<<<")
	
