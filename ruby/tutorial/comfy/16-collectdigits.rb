## -------------
## Tutorial 16 - collecting digits
## -------------
call = Tropo::TropoCall.new($incomingCall)
call.answer

result = call.ask 'Hello.  Please enter any number', :choices => '[DIGITS]'

if result.name == 'choice'
  call.say 'Great, you said ' + result.value
end
	
call.hangup