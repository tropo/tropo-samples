// If this script is called via HTTP, the initial "answer();" can be
// removed.

answer();
event = call("sip:14076463131@10.6.63.201", 
      [
      answerOnMedia: false,
      callerID:      "tel:+666666666666",
      timeout:        12.123,
      onAnswer:       {event-> log("******************** Answered from " + event.value.calleeId) },
      onError:        { log("******************** oops , error *********************") },
      onTimeout:      {  log("******************** timeout *********************") },
      onCallFailure:  {  log("******************** call failed *********************") }
      ] )

if(event.name=='answer'){
  newCall = event.value;
  log("Outgoing call gets answered by " + newCall.calleeId);
}
