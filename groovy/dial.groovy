
answer()
print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>$callFactory");
say("transfering to ");

def ncall = call("sip:81345209477@221.122.54.86", "sip:81345209477@221.122.54.86");
ncall.prompt("call to sip:81345209477@221.122.54.86", "", 10000);
ncall.prompt("This a dial test for JavaScript on the Tropo platform.", "", 10000);
ncall.hangup()
hangup()
