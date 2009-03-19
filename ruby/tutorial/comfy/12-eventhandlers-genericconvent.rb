# -----------
# using the generic onEvent handler instead
# -----------
call = Tropo::TropoCall.new($incomingCall)
call.answer

prompt  = 'Hi. For sales, just say sales or press 1. For support, say support or press 2.'
choices = 'sales( 1, sales), support( 2, support)'

call.ask prompt, :choices => choices, :repeat => 3 do |link|

  link.on :choice do |event|
    case event.value
    when 'sales'
      call.say 'Ok, let me transfer you to sales.'
      transfer '14129272358'
    when 'support'
      call.say 'Sure, let me get support.  Please hold.'
      transfer '14129272341'
    else
      call.say 'An error has occurred, one moment please.'
      transfer '14129272358'
    end
  end
  
  link.on :bad_choice do |event|
    call.say 'I am sorry, I did not understand what you said.'
  end
  
  link.on :timeout do |event|
    call.say 'I am sorry. I did not hear anything.'
  end

end

call.hangup
