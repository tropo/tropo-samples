# -----------
# handling the wrong choice
# -----------
call = Tropo::TropoCall.new($incomingCall)
call.answer

options = { :choices => 'sales(1, sales), support(2, support)' }
            
result = call.ask 'For sales, just say sales or press 1. For support, say support or press 2.', options

call.log result

case result.name
when 'choice'
  case result.value
  when 'sales'
    call.say 'Ok, let me transfer you to sales.'
    call.transfer '14129272358'
  when 'support'
    call.say 'Sure, let me get support.  Please hold.'
    call.transfer '14129272341'
  end
when 'bad_choice'
  call.say 'I am not sure what you wanted.  Goodbye.'
end

call.hangup