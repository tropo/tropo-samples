/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

// --------------------------------------------
// Sample application using many Tropo commands
// --------------------------------------------

def event=ask('where are you heading?',
  [attempts:3,choices:"1st Floor (first, house wares, 1), 2nd Floor (second, bed and bath, 2), 3rd Floor (third, sporting goods, 3)", timeout:10.03456789, 
     onChoices: {event->
     event.onChoice( '1st Floor', { say('Your destination is 1st Floor') } )
     event.onChoice( '2nd Floor', { say('Your destination is 2nd Floor') } )
     event.onChoice( '3rd Floor', { say('Your destination is 3rd Floor') } )
     event.onBadChoice( { say('I can not recognize you. Please input again. ') } ) 
     }, 
     onTimeout: { say('wait input time out') }, 
     onError: { say('You have an error!') },
     onHangup: { println ">>>>>>>>>>>>>>>>>>>>Disconnected by the peer!<<<<<<<<<<<<<<<<<" },
     onEvent: { event->
     if (event.name!="hangup"){ say('inner generic callback got triggered by event ' + event.name)}
     event.onError( { say('You have an error!') } )
     event.onTimeout( { say('wait input time out') } )
     event.onHangup( { println ">>>>>>>>>>>>>>>>Disconnected by the peer!<<<<<<<<<<<<<<<<<" } )
     event.onChoice( '1st Floor', { say('Your destination is 1st Floor') } )
     event.onChoice( '2nd Floor', { say('Your destination is 2nd Floor') } )
     event.onChoice( '3rd Floor', { say('Your destination is 3rd Floor') } )
     event.onBadChoice( { say('I can not recognize you. Please input again. ') } ) 
     }
    ]
)

if (event.name!="hangup"){ 
  say('outer callback got called for event [' + event.name +',' + event.value +']')
  event.onError( { say('You have an error!') } )
  event.onTimeout( { say('wait input time out') } )
  event.onChoice( '1st Floor', { say('Your destination is 1st Floor') } )
  event.onChoice( '2nd Floor', { say('Your destination is 2nd Floor') } )
  event.onChoice( '3rd Floor', { say('Your destination is 3rd Floor') } )
  event.onBadChoice( { say('I can not recognize you') } ) 

  say('Thanks for testing Groovy on the Tropo platform')

}
else{
  print(">>>>>>>>>>>>>>>Disconnected by the peer!<<<<<<<<<<<<<<<<<")
}