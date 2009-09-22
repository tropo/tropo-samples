# -----------
# redirect
# -----------

if $currentCall.callerID == '4075551212'
  answer
  say 'Hello there and goodbye'
  hangup
else
  redirect 'tel:+14075551212'
end