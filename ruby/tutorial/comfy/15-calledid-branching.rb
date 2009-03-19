# -----------
# Changing behavior based on number called
# -----------
call = Tropo::TropoCall.new($incomingCall)
call.answer

if $currentCall.callerID == '4075551111'
  call.say 'Hello Andrew.'
elsif $currentCall.callerID == '4075552222'
  call.say 'Hello Brian.'
end

call.hangup