answer

options = { :choices     => "pulled pork(pulled pork),
                             peanut butter and jelly(pbj, peanut butter and jelly), 
                             turkey sandwich(turky, turky sandwich),
                             club sandwich(club, club sandwich),
                             hot pastrami(pastrami, hot pastrami),
                             ham and cheese(ham and cheese)",
            :repeat      => 3,
            :timeout     => 30,
            :onTimeout   => lambda { say "You must be busy eating a delicious sandwich!  I'll wait for you to finish chewing..." },
            :onBadChoice => lambda { say "You must not be up to speed on your sandwich trivia!  Please try again when your taste in food changes." },
            :onChoice    => lambda { |choice| say "You selected #{choice.value.gsub('_', ' ')}. I couldn't agree more!" }  }

ask 'Hello there! Please tell me, what is the best sandwich ever created', options

say 'Thank you for playing sandwich trivia. Goodbye'

hangup