// --------------------------------------------
// Sample Tropo app in JavaScript
// See http://www.tropo.com for more info
// --------------------------------------------

answer()

var event=prompt("where are you heading?",
   {repeat:3,choices:"1st Floor (first, house wares, 1),\n 2nd Floor (second, bed and bath, 2),\n 3rd Floor (third, sporting goods, 3)", timeout:10.03456789, 
    onChoices: function(event) {
      event.onChoice( "1st Floor", function() { say("Your destination is 1st Floor") } );
      event.onChoice( "2nd Floor", function() { say("Your destination is 2nd Floor") } );
      event.onChoice( "3rd Floor", function() { say("Your destination is 3rd Floor") } ); 
      event.onBadChoice( function() { say("I can not recognize you. Please input again. ") } ); 
    }, 
    onTimeout: function() { say("wait input time out"); }, 
    onHangup: function() { print(">>>>>>>>>>>>>Disconnected by the peer!<<<<<<<<<<<<<<<<<"); }, 
    onError: function() { say("You have an error!"); },
    onEvent: function(event) {
      if(event.name!="hangup"){ say("inner callback got triggered by event " + event.name);}
      event.onError( function() { say("You have an error err! ") } );
      event.onTimeout( function() { say("wait input time out") } );
      event.onHangup( function() { print(">>>>>>>>>>>>>Disconnected by the peer!<<<<<<<<<<<<<<<<<") } );
      event.onChoice( "1st Floor", function() { say("Your destination is 1st Floor") } );
      event.onChoice( "2nd Floor", function() { say("Your destination is 2nd Floor") } );
      event.onChoice( "3rd Floor", function() { say("Your destination is 3rd Floor") } ); 
      event.onBadChoice( function() { say("I can not recognize you. Please input again. ") } ); 
    }
  }
);

if(event.name!="hangup"){
  say("run outer call back for event [" + event.name +"," + event.value +"]");
  event.onError( function() { say("You have an error err! ") } );
  event.onTimeout( function() { say("wait input time out") } );
  event.onChoice( "1st Floor", function() { say("Your destination is 1st Floor") } );
  event.onChoice( "2nd Floor", function() { say("Your destination is 2nd Floor") } );
  event.onChoice( "3rd Floor", function() { say("Your destination is 3rd Floor") } ); 
  event.onBadChoice( function() { say("I can not recognize you") } ); 
  event.onChoice( "namatch", function() { say("I can not recognize you") } ); 
  say("Thanks for testing JavaScript on the Tropo platform");
  hangup()
}
else{
  print(">>>>>>>>>>>>>>>Disconnected by the peer!<<<<<<<<<<<<<<<<<");
}
