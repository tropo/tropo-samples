// --------------------------------------------
// reject based on callerid
// See http://www.tropo.com for more info
// --------------------------------------------

if (currentCall.callerID == '4075551111') 
    {
	answer();
	say("Hello world!");
	hangup();
    }
 else
    reject();
