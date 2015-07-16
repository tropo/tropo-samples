/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

// --------------------------------------------
// Simple example of recording audio
// --------------------------------------------

event=record("Leave your message at the beep.  Thanks!",
  [
    beep:true, silenceTimeout: 5, maxTime:60, timeout:10,
    onRecord: {event-> say("you said " + event.recordURI )  }
  ] );

log( "event.recordURI = " + event.recordURI );
