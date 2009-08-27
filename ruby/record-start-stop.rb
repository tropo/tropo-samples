answer
 
say 'Thank you for calling the recording service.'
startCallRecording "http://tropo-audiofiles-to-s3.heroku.com/post_audio_to_s3?filename=start-stop-test.wav"
 
prompt 'Do you like chocolate sundaes?', { :choices => 'yes, no' }
 
say 'Great!'
stopCallRecording
say 'Thank you for using the recording service.'
 
hangup