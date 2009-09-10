<?php 

answer(); 

// Have to ask an initial question and wait for a response 
// Otherwise it will run through to the hangup(); 
ask ("Hello there! What would you like to know about? Say cats, dogs, or fish.", 
      array( 
        // term(term, synonym, synonym) 
        // words and phrases that trigger the action are in ()'s 
        "choices" => "cats(cat, cats, feline), dogs(dog, dogs, big dogs), fish(fish)", 
        "repeat"  => 3, // repeat 3 times before moving on 
        "timeout" => 30, // ask the initial question again 
        "onEvent" => create_function( '$event', 

                  'if ($event->name == "badChoice") say( "I\'m sorry, I didn\'t quite understand. Say cats, dogs, or fish."); 
                  if ($event->name == "timeout") say( "Are you sure that you don\'t want to know about cats, dogs OR fish?!"); 
                  if ($event->name == "choice") 
                  { 
                      if ($event->value == "cats") 
                      { 
                        say( "Cats like to eat, sleep, lather, rinse, repeat." ); 
                      } 
                      if ($event->value == "dogs") 
                      { 
                        say( "Dogs like tearing up your most prized possessions." ); 
                      } 
                      if ($event->value == "fish") 
                      { 
                        say( "Fish like to swim in circles - it keeps the water circulating." ); 
                      } 

                      // make their choice available outside of the array 
                      define(choice, $event->value); 

                  }' 
              ) 
        ) 
    ); 

wait(3000); 
say ( "You probably already knew that about ".choice." though, right?" ); 

wait(8000); 
say ( "Sure buddy, sure. Adios." ); 

hangup(); 

?>