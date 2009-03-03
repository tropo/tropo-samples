# -----------
# reject based on callerid
# -----------

log "*"*100 + $currentCall.inspect

if $currentCall.callerID == '4153675082'
	answer
	say 'Hello there and goodbye'
	hangup
else
  reject
end
