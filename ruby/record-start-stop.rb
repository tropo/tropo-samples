# Copyright (c) 2009 - 2015 Tropo, now part of Cisco
# Released under the MIT license. See the file LICENSE
# for the complete license

say 'Thank you for calling the recording service.'
startCallRecording "http://tropo-audiofiles-to-s3.heroku.com/post_audio_to_s3?filename=start-stop-test.wav"
 
ask 'Do you like chocolate sundaes?', { :choices => 'yes, no' }
 
say 'Great!'
stopCallRecording
say 'Thank you for using the recording service.'
