# Copyright (c) 2009 - 2015 Tropo, now part of Cisco
# Released under the MIT license. See the file LICENSE
# for the complete license


event=ask("where are you heading?",
   {'repeat'=>2,'choices'=>"1st Floor (first, house wares, 1), 2nd Floor (second, bed and bath, 2), 3rd Floor (third, sporting goods, 3)", 'timeout'=>10.03456789, 
    'onChoices'=>lambda { | event |
      event.onChoice( "1st Floor", lambda { say "Your destination is 1st Floor" } )
      event.onChoice( "2nd Floor", lambda { say "Your destination is 2nd Floor" } )
      event.onChoice( "3rd Floor", lambda { say "Your destination is 3rd Floor" } ) 
      event.onBadChoice( lambda { say "I can not recognize you. Please input again. " } ) 
    }, 
    'onTimeout'=>lambda { say "wait input time out" }, 
    'onHangup'=>lambda { puts ">>>>>>>>>>>>>>>>>>>Disconnected by the peer!<<<<<<<<<<<<<<<<<" },
    'onError'=>lambda { say "You have an error!" },
    'onEvent'=>lambda { | event |
      say "inner callback got triggered by event " + event.name if event.name!="hangup"
      event.onError( lambda { say "You have an error! " } )
      event.onTimeout( lambda { say "wait input time out" } )
      event.onHangup( lambda { puts ">>>>>>>>>>>>>>>Disconnected by the peer!<<<<<<<<<<<<<<<<<" } )
      event.onChoice( "1st Floor", lambda { say "Your destination is 1st Floor" } )
      event.onChoice( "2nd Floor", lambda { say "Your destination is 2nd Floor" } )
      event.onChoice( "3rd Floor", lambda { say "Your destination is 3rd Floor" } ) 
      event.onBadChoice( lambda { say "I can not recognize you. Please input again. " } ) 
    }
  }
)

if event.name!="hangup"
  say "run outer call back for event [#{event.name},#{event.value}]"
  event.onError( lambda { say "You have an error! " } )
  event.onChoice( "1st Floor", lambda { say "Your destination is 1st Floor" } )
  event.onChoice( "2nd Floor", lambda { say "Your destination is 2nd Floor" } )
  event.onChoice( "3rd Floor", lambda { say "Your destination is 3rd Floor" } ) 
  event.onBadChoice( lambda { say "I can not recognize you " } ) 
  say "Thanks for testing Ruby on the Tropo platform"
else
  puts ">>>>>>>>>>>>>>>Disconnected by the peer!<<<<<<<<<<<<<<<<<"
end