/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

say('Welcome to the Tropo recording service.')
startCallRecording("http://example.com/post_audio?filname=mynewfile.wav")

ask('Welcome to the Groovy recording test, would you like to be recorded? ', [choices: 'yes, no'])

say('If you said yes, hooray!  If you said no, sorry about that.')
stopCallRecording()
say('Thank you for using the Tropo recording service. Goodbye.')