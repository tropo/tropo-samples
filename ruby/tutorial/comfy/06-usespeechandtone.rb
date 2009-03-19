# -----------
# using both speech and touch-tone input
# -----------
call = Tropo::TropoCall.new($incomingCall)
call.answer

options = { :choices => 'sales( 1, sales), support( 2, support)', 
            :repeat  => 3 }
            
result = call.ask 'For sales, just say sales or press 1. For support, say support or press 2.', options

if result.name=='choice'
  case result.value
  when 'sales'
    call.say 'sales is not available right now.'
  when 'support'
    call.say 'support is currently on the other line.'
  end
end

call.hangup