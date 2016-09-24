/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

// --------------------------------------------
// Simple example of recording
// --------------------------------------------

record("Leave your message after the beep. Thanks!",
  {
    beep:true, silenceTimeout: 5, maxTime:60, timeout:10,
    onRecord:function(event) 
        { 
          // Note that by default, Tropo stores the recorded audio file on its runtime server. 
          // This temporary file cannot be accessed externall: only your script will be able to read the audio file as it gets executed inside tropo hosting environment. 
          //
          // If you want to keep the audio file in a safe place, use the recordURI parameter.
          //     - to specify your Tropo files directory, specify recordURI:"ftp://ftp.tropo.com" and your user/password,
          //     - or simply push the file to any external service: recordURI:"https;//..." or "ftp://..."
          //
          // for more info, check: https://www.tropo.com/docs/hosting-debugging-logs/audio
          say("you said " + event.value );  
        }
  } );
