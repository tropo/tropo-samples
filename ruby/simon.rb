# Simon - by Ryan Campbell

answer

# Set initial state
simon = ''
win = true
inchar = ''

options = { "choices"  => "1,2,3,4,5,6,7,8,9,0",
            "onChoice" => lambda { |event| inchar = event.value.to_s}
          }

# keep going up to a pattern of 20 digits
while (win == true) && (simon.length <= 20)

  # add another character to the pattern and rad the pattern to the caller
  simon += rand(10).to_s
  say "Simon says"
  simon.each_byte {|b| say b.chr} 

  #now get the user input
  say "you say"
  i = 0
  while i < simon.length 
    ask "", options
  
    # read back each character of user input
    say inchar
 
    # if they entered the incorrect character then we're done.
    if inchar != simon[i].chr then
      win = nil
      say "Sorry, that's not right.  goodbye."
      hangup
      break
    end
  
    i += 1
  end  

  # if they won that round then see if we need to continue
  if win == true then
    say "Good Job!"
    wait 3
    if  simon.length > 20 then
      say "You beat simon!"
      hangup
      break
    else
      say "Next round"
    end
  end

end  

hangup
