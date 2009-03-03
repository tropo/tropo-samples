# -----------
# Changing behavior based on number called
# -----------

answer

if $currentCall.callerID == '4075551111'
    say 'Hello Andrew.'
elsif $currentCall.callerID == '4075552222'
    say 'Hello Brian.'
end

hangup