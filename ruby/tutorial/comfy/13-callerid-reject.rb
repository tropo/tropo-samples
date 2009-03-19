# -----------
# reject based on callerid
# -----------
call = Tropo::TropoCall.new($incomingCall)

call.log $currentCall

if $currentCall.callerID == '4155551212'
	call.answer
	call.say 'Hello there and goodbye'
	call.hangup
else
  call.reject
end
