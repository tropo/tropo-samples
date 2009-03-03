// --------------------------------------------
// Example of creating outgoing calls
// See http://www.tropo.com for more info
// --------------------------------------------

// If this script is called via HTTP, the initial "answer();" can be
// removed.

answer();
event = call("sip:14076463131@10.6.63.201", 
      {
      answerOnMedia: false,
      callerID:      "tel:+666666666666",
      timeout:        12.123,
      onAnswer:       function(event){ log("******************** Answered from " + event.value.calleeId) },
      onError:        function( ) { log("******************** oops , error *********************") },
      onTimeout:      function( ) {  log("******************** timeout *********************") },
      onCallFailure:  function( ) {  log("******************** call failed *********************") }
      } )

if(event.name=='answer'){
  newCall = event.value;
  log("Outgoing call gets answered by " + newCall.calleeId);
}
