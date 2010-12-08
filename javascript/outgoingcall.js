// --------------------------------------------
// Example of creating outgoing calls
// See http://www.tropo.com for more info
// --------------------------------------------

event = call("sip:14075551313@10.6.63.201", 
      {
      answerOnMedia: false,
      callerID:      "tel:+4075551212",
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
