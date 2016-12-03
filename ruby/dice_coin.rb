# Copyright (c) 2009 - 2015 Tropo, now part of Cisco
# Released under the MIT license. See the file LICENSE
# for the complete license

@dice6 = 1 + rand(6)
@dice20 = 1 + rand(20)
@coin = 1 + rand(2)
@rps = 1 + rand(3)
  
def heads_tails()
  if (@coin == 1)
    return "You got heads."
  else
    return "You got tails."
  end
end
    
@ht_var = heads_tails()

def rock_paper_scissors()
  if (@rps == 1)
    return "You got rock."
  elsif (@rps == 2)
    return "You got paper."
  else
    return "You got scissors"
  end
end

@rps_var = rock_paper_scissors()

def the_ask()
  ask "Welcome to the chance facilitator.  Select 1 for six sided dice, 2 for twenty sided dice, 3 for a coin flip, 4 for rock paper scissors.", {
    :choices => "1(one, 1), 2(two, 2), 3(three, 3), 4(four, 4)",
    :timeout => 60.0,
    :attempts => 3,
    :onBadChoice => lambda { |event|
        say "I’m sorry,  I didn’t understand that. Please try again."
    },
    :onChoice => lambda { |event|
        say "You chose " + event.value + "."
            if (event.value == "1")
              say "You rolled a " + @dice6.to_s + "."
            elsif (event.value == "2")
              say "You rolled a " + @dice20.to_s + "."
            elsif (event.value == "3")
              say @ht_var
            else
              say @rps_var
            end
        }
    }
end

if $currentCall.initialText != nil
  ask "", :choices => "[ANY]"
  the_ask()
else
  the_ask()
end