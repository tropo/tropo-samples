# -----------
# redirect
# -----------

answer

if currentCall.callerID == '4075551212'
  answer
  say 'Hello there and goodbye'
  hangup
else
  redirect '14076463131'
end