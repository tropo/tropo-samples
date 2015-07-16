# Copyright (c) 2009 - 2015 Tropo, now part of Cisco
# Released under the MIT license. See the file LICENSE
# for the complete license

options = { :answerOnMedia => false,
            :callerID      => '+14157044517',
            :timeout       => 12.123,
            :onAnswer      => lambda { |event| log '******************** Answered from ' + event.inspect.to_s },
            :onError       => lambda { |event| log '******************** oops , error*********************' + event.inspect.to_s },
            :onTimeout     => lambda { |event| log '******************** timeout *********************' + event.inspect.to_s },
            :onCallFailure => lambda { |event| log '******************** call failed *********************' + event.inspect.to_s }
          }

event = call 'tel:+14155551212', options

if event.name == 'answer'
  log 'Outgoing call gets answered by ' + event.value.calledID
end
