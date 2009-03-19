# -----------
# hello, world
# -----------
call = Tropo::TropoCall.new($incomingCall)
call.answer
 
call.say 'Hello, World - your call is very important to us.'
 
call.hangup