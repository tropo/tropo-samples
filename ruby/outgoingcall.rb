# If this script is called via HTTP, the initial "answer();" can be
# removed.
 
answer
options = { :answerOnMedia => false,
            :callerID      => 'tel:+4157044517',
            :timeout       => 12.123,
            :onAnswer      => lambda { |event| log '******************** Answered from ' + event.inspect.to_s },
            :onError       => lambda { |event| log '******************** oops , error*********************' + event.inspect.to_s },
            :onTimeout     => lambda { |event| log '******************** timeout *********************' + event.inspect.to_s },
            :onCallFailure => lamdba { |event| log '******************** call failed *********************' + event.inspect.to_s }
          }

event = call 'tel:14155551212', options

if event.name == 'answer'
  log 'Outgoing call gets answered by ' + event.value.calleeID
end
