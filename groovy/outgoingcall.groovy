/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

// --------------------------------------------
// outgoing call example
// --------------------------------------------

// Place a phone number here
def phoneNo = 14075551212

event = call("sip:${phoneNo}@10.6.63.201", 
      [
      answerOnMedia: false,
      callerID:      "+14075551313",
      timeout:        60.3456,
      // Error in debugger if event.value.calledID is used
      onAnswer:       { event-> log("******************** Answered from ") },
      onError:        { log("******************** oops , error *********************") },
      onTimeout:      { log("******************** timeout *********************") },
      onCallFailure:  { log("******************** call failed *********************") }
      ] )

if(event.name=='answer'){
  newCall = event.value;
  newCall.say("This is a Tropo call, thank you for answering!")
}

