// --------------------------------------------
// call transfer example
// See http://www.tropo.com for more info
// --------------------------------------------

answer()
print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + callFactory);
say("transfering to ");

def ncall = currentCall.transfer("sip:914074181800@10.6.63.201", [
        answerOnMedia: false,
        callerId:      "tel:+14076179024",
        timeout:       60.3456,
        method:        "bridged", // fixed to bridged currently
        playrepeat:    3,
        playvalue:     "Ring... Ring... Ring...",
        choices:       "1,2,3,4,5,6,7,8,9,0,*,#",
                onSuccess:     { ncall-> log("*********transfered to $ncall.value.calleeId") },  
                onError:       { ncall-> log("*********transfer error") },  
                onTimeout:     { ncall-> log("*********transfer timeout") },  
                onCallFailure: { ncall-> log("*********transfer failed") },  
                onChoice:      { ncall-> log("*********transfer canceled") }  
        ]
)

print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + ncall);

hangup()

