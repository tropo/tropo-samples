# -----------
# Changing behavior based on number called
# -----------

answer

if $currentCall.calledID == '4075551111'
    say 'Hello Andrew.'
elsif $currentCall.calledID == '4075552222'
    say 'Hello Brian.'
end

hangup