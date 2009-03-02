def asDigits(instr) {
  def s  = '';
 
  for (def i=0; i < instr.length(); i++) {
    s = s + instr.charAt(i) + ' ';
  }

  return s;
}

answer();

def sipuri = currentCall.callerID;

say("You called from " + asDigits(sipuri.substring(0,10)));

hangup();
