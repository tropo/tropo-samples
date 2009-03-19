# -----------
# using speech input instead of touch-tone (DTMF)
# -----------
call = Tropo::TropoCall.new($incomingCall)
call.answer

options = { :choices => 'sales, support', 
            :repeat  => 3 }
            
result = call.ask 'For sales, just say sales.  For support, say support.', options

if result.name == 'choice'
  case result.value
  when 'sales'
    call.say 'sales is not available right now.'
  when 'support'
    call.say 'support is currently on the other line.'
  end
end

call.hangup