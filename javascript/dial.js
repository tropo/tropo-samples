// --------------------------------------------
// From inside an active call, how do you dial
// another number and direct your prompts and
// other Tropo actions to that new call?
//
// This sample demonstrates how to use Tropo's
// objects to maintain two concurrent calls.
//
// http://www.tropo.com
// --------------------------------------------

say("Thank you for calling. This is call A.");

var newcall = call("sip:user@example.com");
newcall.value.say("This is call B");

say("This is still call A.");
newcall.value.say("Call B");
say("Call A");

// Hangup call B
newcall.hangup();
// now newcall.value.say("Call B"); would fail. the call is gone.

say("Call A is still connected.");

// The call will implicitly end when the script ends. 
// No hangup() needed here, but we'll demonstrate it anyway.
hangup(); // Call A