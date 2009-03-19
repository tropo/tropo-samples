# -----------
# handling bad choices and no response (timeout) with event handlers
# -----------
call = Tropo::TropoCall.new($incomingCall)
call.answer

prompt = 'For sales, just say sales or press 1. For support, say support or press 2.'

call.ask prompt, :choices => 'sales( 1, sales), support( 2, support)', :repeat => 3, :timeout => 10 do |link|

  link.on :choice do |event|
    case event.value
    when 'sales'
      call.say 'Ok, let me transfer you to sales.'
      call.transfer '14129272358'
    when 'support'
      call.say 'Sure, let me get support.  Please hold.'
      call.transfer '14129272341'
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
