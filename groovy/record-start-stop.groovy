answer()

say('Welcome to the Tropo recording service.')
startCallRecording("http://tropo.a-domain.com/post_audio?filname=mynewfile.wav")

prompt('Welcome to groovy recording test', [choices: 'yes, no'])

say('Great!')
stopCallRecording
say('Thank you for using the Tropo recording service. Goodbye.')

hangup()