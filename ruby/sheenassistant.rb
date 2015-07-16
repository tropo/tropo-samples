# Copyright (c) 2009 - 2015 Tropo, now part of Cisco
# Released under the MIT license. See the file LICENSE
# for the complete license

@voice = {:voice => "kate"}

def the_ask()
  ask "<speak><prosody rate='-5%' volume='soft'>Press 1 to be transferred to Mr. Sheen's cell phone.  Press 2 to record a message for Mr. Sheen.  Press 3 to send Mr. Sheen a text message.  Press 4 to hear a personal message from Mr. Sheen.  Press 5 to taste the glory that is, tigerblood. </prosody></speak>", {
    :choices => "1, 2, 3, 4, 5",
    :timeout => 60.0,
    :attempts => 100,
    :voice => "kate",
    :mode => "dtmf",
    :onBadChoice => lambda { |event|
        say "http://hosting.tropo.com/48562/www/audio/whatdoesthatmean.mp3 http://hosting.tropo.com/48562/www/audio/droopyeyedarmless.mp3" 
        say "<speak><prosody rate='-5%' volume='soft'>Please try again, apparently you're not winning.</prosody></speak>", @voice
    },
    :onChoice => lambda { |event|
            if (event.value == "1")
              say "<speak><prosody rate='-5%' volume='soft'>Transferring, please wait.  Mr. Sheen, are you ready?</prosody></speak>", @voice
              say "http://hosting.tropo.com/48562/www/audio/no.mp3"
              say "<speak><prosody rate='-5%' volume='soft'>May we ask, why?</prosody></speak>", @voice
              say "http://hosting.tropo.com/48562/www/audio/notgoingto.mp3"
              say "<speak><prosody rate='-5%' volume='soft'>Are you taking any drugs?</prosody></speak>", @voice
              say "http://hosting.tropo.com/48562/www/audio/drugcalledcharliesheen.mp3"
              say "<speak><prosody rate='-5%' volume='soft'>We understand, we'll try again later.</prosody></speak>", @voice
            elsif (event.value == "2")
              record "http://hosting.tropo.com/48562/www/audio/drugcalledcharliesheen.mp3", {
                :beep => true,
                :maxTime => 900,
                :recordURI => "http://example.com/recording.rb",
                :transcriptionOutURI => "mailto:youremail@gmail.com"
                } 
            elsif (event.value == "3")
              say "http://hosting.tropo.com/48562/www/audio/droopyeyedarmless.mp3 http://hosting.tropo.com/48562/www/audio/bringit.mp3 http://hosting.tropo.com/48562/www/audio/bringit.mp3" 
              say "<speak><prosody rate='-5%' volume='soft'>We're sorry, Mr. Sheen is apparently not accepting messages at this time.</prosody></speak>", @voice
              say "http://hosting.tropo.com/48562/www/audio/bringit.mp3 http://hosting.tropo.com/48562/www/audio/bringit.mp3 http://hosting.tropo.com/48562/www/audio/droopyeyedarmless.mp3 http://hosting.tropo.com/48562/www/audio/tigerblood.mp3 http://hosting.tropo.com/48562/www/audio/bringit.mp3"
            elsif (event.value == "4")
              say "http://hosting.tropo.com/48562/www/audio/cantcancer.mp3"
              say "<speak><prosody rate='-5%' volume='soft'>I think we all agree that was very inspirational.</prosody></speak>", @voice
              say "http://hosting.tropo.com/48562/www/audio/whatsnottolove.mp3"
              say "<speak><prosody rate='-5%' volume='soft'>Indeed.</prosody></speak>", @voice
            else 
              say "http://hosting.tropo.com/48562/www/audio/borrowbrain.mp3"
              say "<speak><prosody rate='-5%' volume='soft'>I don't think that's quite what they were expecting Mr. Sheen.</prosody></speak>", @voice
              say "http://hosting.tropo.com/48562/www/audio/whatdoesthatmean.mp3"
              say "<speak><prosody rate='-5%' volume='soft'>I have no idea.</prosody></speak>", @voice
              say "http://hosting.tropo.com/48562/www/audio/lasttimedrugs.mp3"
              say "<speak><prosody rate='-5%' volume='soft'>I believe you.</prosody></speak>", @voice
              say "http://hosting.tropo.com/48562/www/audio/7gramrocks.mp3"
              say "<speak><prosody rate='-5%' volume='soft'>Seriously, I believe you.</prosody></speak>", @voice
              say "http://hosting.tropo.com/48562/www/audio/biwinning.mp3"
              say "<speak><prosody rate='-5%' volume='soft'>Sure, okay, we'll go with that.</prosody></speak>", @voice
            end
        }
    }
end
 
if $currentCall.initialText != nil
  ask "", :choices => "[ANY]"
  say "We're sorry, this personal assistant is voice only.  All green things must die."
else
  wait(3000)
  say "<speak><prosody rate='-5%' volume='soft'>Welcome to Charlie Sheen's automated personal assistant.</prosody></speak>", @voice
  the_ask()
  say "<speak><prosody rate='-5%' volume='soft'>Mr. Sheen thanks you for calling.  Want to make your own personal assistant?  Check out tro po dot com, that's t r o p o dot c o m.</prosody></speak>", @voice
  say "http://hosting.tropo.com/48562/www/audio/f18bro.mp3"
end