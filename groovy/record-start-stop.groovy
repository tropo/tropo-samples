answer()

say('Welcome to the Tropo recording service.')
startCallRecording("http://example.com/post_audio?filname=mynewfile.wav")

ask('Welcome to the Groovy recording test, would you like to be recorded? ', [choices: 'yes, no'])

say('If you said yes, hooray!  If you said no, sorry about that.')
stopCallRecording
say('Thank you for using the Tropo recording service. Goodbye.')

hangup()