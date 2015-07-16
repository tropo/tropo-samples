/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

// --------------------------------------------
// call transfer example
// --------------------------------------------

print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + callFactory);
say("transferring to ");

def ncall = transfer("sip:914074181800@10.6.63.201", [
        answerOnMedia: false,
        callerId:      "+14075551212",
        timeout:       60.3456,
        method:        "bridged", // fixed to bridged currently
        playrepeat:    3,
        playvalue:     "Ring... Ring... Ring...",
        onSuccess:     { ncall-> log("*********transfered to $ncall.value.calledID") },  
        onError:       { ncall-> log("*********transfer error") },  
        onTimeout:     { ncall-> log("*********transfer timeout") },  
        onCallFailure: { ncall-> log("*********transfer failed") }  
        ]
)

print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + ncall);

