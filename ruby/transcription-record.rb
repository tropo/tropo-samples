answer
say 'Welcome to the Ruby recording test'

event = record('Say something after the beep.',
               { :repeat              => 0, 
                 :bargein             => true, 
                 :beep                => true, 
                 :silenceTimeout      => 2, 
                 :maxTime             => 30, 
                 :timeout             => 4.03456789, 
                 :recordURI           => 'http://tropo.to-a-domain.com/post_audio?filename=file123456.wav',
                 :transcriptionOutURI => 'http://tropo.to-a-domain.com/receive_transcription', 
                 :transcriptionID     => '123456' })

log 'Recorded file: ' + event.recordURI
say 'Thanks for testing Ruby on the Tropo platform'
hangup