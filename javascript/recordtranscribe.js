// --------------------------------------------
// Example showing recording and transcription by @Skram

//  This example utilizes two additional samples to create a complete application:

// Review http://github.com/voxeo/tropo-audiofiles-to-s3>tropo-audiofiles-to-s3, which is applied when the application references "/post_audio_to_s3?filename=".

// Review http://labs.voxeo.com/2009/08/27/posting-tropo-transcriptions-to-google-appengine/, which is applied when the application references "/receive_transcription".

// See http://www.tropo.com for more info
// --------------------------------------------



// CALL VARIABLES
date = new Date();
t0 = date.getTime();
var unique_id = currentCall.callerID + "_" + t0;
var base_url = "http://YOUR.SERVER"

// CALL FLOW
answer();
wait(1500);

log("Incoming call info: callerID:" + currentCall.callerId + ", calledID:" + currentCall.calledId +", callerName:" + currentCall.callerName + ", calledName:" + currentCall.calledName);

var event = record("Please leave your message after the tone.",
{  // RECORD VARIABLES
repeat: 2,
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