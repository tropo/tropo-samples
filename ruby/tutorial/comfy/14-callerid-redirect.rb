# -----------
# redirect
# -----------
call = Tropo::TropoCall.new($incomingCall)

if $currentCall.callerID == '4075551212'
  call.answer
  call.say 'Hello there and goodbye'
  call.hangup
else
  call.redirect 'tel:14075551212'
end