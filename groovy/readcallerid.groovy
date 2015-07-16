/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

// --------------------------------------------
// reads out the caller ID
// --------------------------------------------

def asDigits(instr) {
  def s  = '';
 
  for (def i=0; i < instr.length(); i++) {
    s = s + instr.charAt(i) + ' ';
  }

  return s;
}

def sipuri = currentCall.callerID;

say("You called from " + asDigits(sipuri.substring(0,10)));