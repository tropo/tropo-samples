// --------------------------------------------
// read out the caller ID
// See http://www.tropo.com for more info
// --------------------------------------------

function asDigits(instr) {
  var s  = '';
 
  for (var i=0; i < instr.length; i++) {
    s = s + instr.charAt(i) + ' ';
  }

  return s;
}

answer();

var sipuri = currentCall.callerID;

say("You called from " + asDigits(sipuri.slice(0,10)));

hangup();
