/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

// --------------------------------------------
// Example of creating outgoing calls
// --------------------------------------------

event = call("+14075551313", 
      {
      answerOnMedia: false,
      callerID:      "tel:+14075551212",
      timeout:        12.123,
      onAnswer:       function(event){ log("******************** Answered from " + event.value.calledID) },
      onError:        function( ) { log("******************** oops , error *********************") },
      onTimeout:      function( ) {  log("******************** timeout *********************") },
      onCallFailure:  function( ) {  log("******************** call failed *********************") }
      } )

if(event.name=='answer'){
  newCall = event.value;
  log("Outgoing call gets answered by " + newCall.calledID);
}
