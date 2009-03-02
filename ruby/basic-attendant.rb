# ===========
# Tropo basic auto attendant sample application in Ruby
# v0.9 Jason Goecke - Modeled on JS example by jrt
# ===========

# define the list of contacts

Contacts = { :jsgoecke => { :name_choices => "Jason, Jason Goecke", :number => "18005551212" },
             :jicksta  => { :name_choices => "Jay, Jay Phillips",   :number => "14155551212" } }

# turn the contacts into a comma seperated list of names
def list_names
  list_of_names = String.new
  Contacts.each { |contact| list_of_names = list_of_names + contact[1][:name_choices] + ", " }
  return list_of_names
end

# turn the options into something like:
# jsgoecke(Jason, Jason Goecke),jicksta(Jay, Jay Phillips)
def list_options
  list_of_options = String.new
  Contacts.each { |contact| list_of_options = list_of_options + contact[0].to_s + "(" + contact[1][:name_choices] + ")," }
  return list_of_options  
end

# start

#answer the phone and play the initial greeting

answer 30
prompt "hello, and thank you for calling."

options = { "repeat"  => 3,
            "timeout" => 5,
            "choices" => list_options,
            # Create a callback on an event
            "onEvent" => lambda { |event|
              case event.name
              # When the user has selected a valid option for the list provided in the prompt
              when "choice"
                # Tell the user that we understand them and that we will transfer them
                say "ok, you said " + event.value + ".  Please hold while I transfer you."
                options = { "answerOnMedia" => false,
                            "callerID"      => "tel:+14076179024",
                            "timeout"       => 60.3456,
                            "method"        => "bridged", # fixed to bridged currently
                            "playrepeat"    => 3,
                            "playvalue"     => "Ring... Ring... Ring...",
                            "choices"       => "1,2,3,4,5,6,7,8,9,0,*,#",
                            # Create a series of callbacks to reflect the status of the call result
                            "onSuccess"     => lambda { |event| log "Xfer Success!: " + event.inspect.to_s },
                            "onError"       => lambda { |event| log "Xfer Error!: " + event.inspect.to_s },
                            "onTimeout"     => lambda { |event| log "Xfer Timeout!: " + event.inspect.to_s },
                            "onCallFailure" => lambda { |event| log "Xfer Failure!: " + event.inspect.to_s },
                            "onChoice"      => lambda { |event| log "Xfer Cancelled!: " + event.inspect.to_s }
                          }
                transfer_event = transfer "sip:9" + Contacts[event.value.to_sym][:number] + "@10.6.63.201", options
              # When a user has said something not understood to be on the list provided in the prompt
              when "badChoice"
                say "I'm sorry, I didn't understand what you said."
              # When the user has remained silent up to the timeout
              when "timeout"
                say "I'm sorry, I didn't hear anything."
              end
            }
          }

# prompt the user for the name of the person they desire          
event = prompt "Who would you like to call?  Just say " + list_names, options

# Hangup the call once complete
hangup
