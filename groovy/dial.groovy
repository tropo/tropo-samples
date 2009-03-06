// --------------------------------------------
// demonstration of calling out
// See http://www.tropo.com for more info
// --------------------------------------------

answer()
print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>$callFactory")
say("transfering to ")

// Place a phone number here
def phoneNo = 14074181800

def event = call("sip:${phoneNo}@10.6.63.201",
      [
      answerOnMedia: false,
      callerID:      "tel:+666666666666",
      timeout:        60.3456,
      // Error in debugger if event.value.calleeId is used
      onAnswer:       { event-> log("******************** Answered from ") },
      onError:        { log("******************** oops , error *********************") },
      onTimeout:      { log("******************** timeout *********************") },
      onCallFailure:  { log("******************** call failed *********************") }
      ] )

if (event.choice == 'answer'){
  def ncall=event.value
  ncall.say("call to sip:" + phoneNo + "@10.6.63.201")
  ncall.say("This a dial test for Groovy on the Tropo platform.")
  ncall.hangup()
}
hangup()

