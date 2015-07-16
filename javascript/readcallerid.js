/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

// --------------------------------------------
// read out the caller ID
// --------------------------------------------

function asDigits(instr) {
  var s  = '';
 
  for (var i=0; i < instr.length; i++) {
    s = s + instr.charAt(i) + ' ';
  }

  return s;
}


var sipuri = currentCall.callerID;

say("You called from " + asDigits(sipuri.slice(0,10)));

