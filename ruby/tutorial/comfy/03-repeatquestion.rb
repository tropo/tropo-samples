# -----------
# repeating the question
# -----------
call = Tropo::TropoCall.new($incomingCall)
call.answer

options = { :choices => '1, 2', 
            :repeat  => 3 }
            
result = call.ask 'For sales, press 1. For support, press 2.', options

if result.name == 'choice'
  case result.value
  when '1'
    call.say 'sales is not available right now.'
  when '2'
    call.say 'support is currently on the other line.'
  end
end

call.hangup