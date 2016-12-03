/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

// --------------------------------------------
// Example showing recording and transcription by @Skram

//  This example utilizes two additional samples to create a complete application:

// Review http://github.com/tropo/tropo-audiofiles-to-s3>tropo-audiofiles-to-s3, which is applied when the application references "/post_audio_to_s3?filename=".

// Review http://tropo.com/2009/08/27/posting-tropo-transcriptions-to-google-appengine/, which is applied when the application references "/receive_transcription".

// --------------------------------------------



// CALL VARIABLES
date = new Date();
t0 = date.getTime();
var unique_id = currentCall.callerID + "_" + t0;
var base_url = "http://YOUR.SERVER"

// CALL FLOW

wait(1500);

log("Incoming call info: callerID:" + currentCall.callerId + ", calledID:" + currentCall.calledId +", callerName:" + currentCall.callerName + ", calledName:" + currentCall.calledName);

var event = record("Please leave your message after the tone.",
{  // RECORD VARIABLES
    attempts: 2,
    record: true,
    beep: true,
    timeout: 5,
    maxTime: 60,
    bargein: false,
    recordURI: base_url+"/post_audio_to_s3?filename="+unique_id+".wav",
    transcriptionOutURI: base_url+"/receive_transcription",
    transcriptionId: unique_id,

// RECORD EVENTS
    onEvent: function(event) {
        event.onTimeout(function() {
            say("Sorry, but I did not hear anything. Let's try that again.");
        });
        event.onRecord(function(event) {
say("You said:" + event.recordURI);
        });
    }

}
);

say("Thank you for using Tropo Record and Transcribe.");