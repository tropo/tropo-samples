answer()
print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>$callFactory");
say("transfering to ");
//incomingCall.transfer("sip:mike@221.122.54.86", 30000);
//var ncall = callFactory.call("sip:81345209477@221.122.54.86", "sip:81345209477@221.122.54.86", false, 30000);
//var ncall=incomingCall.transfer("sip:81345209477@221.122.54.86", 30000);
//ncall.prompt("transfering to sip:81345209477@221.122.54.86", "", 10000);

def ncall = call("sip:81345209477@221.122.54.86", "sip:81345209477@221.122.54.86");
ncall.prompt("call to sip:81345209477@221.122.54.86", "", 10000);
ncall.prompt("This a dial test for JavaScript on the Tropo platform.", "", 10000);
ncall.hangup()
hangup()
