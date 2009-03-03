# -----------
# using the generic onEvent handler instead
# -----------

answer

options = { :choices => 'sales( 1, sales), support( 2, support)',
            :repeat  => 3,
            :onEvent => lambda { |event|
                                  case event.name
                                  when 'badChoice'
                                    say 'I am sorry, I did not understand what you said.'
                                  when 'timeout'
                                    say 'I am sorry. I did not hear anything.'
                                  when 'choice'
                                    case event.value
                                    when 'sales'
                                      say 'Ok, let me transfer you to sales.'
                                      transfer '14075551212'
                                    when 'support'
                                      say 'Sure, let me get support.  Please hold.'
                                      transfer '14085551212'
                                    else
                                      transfer '14075551212'
                                    end
                                  end
                                }
          }

ask 'Hi. For sales, just say sales or press 1. For support, say support or press 2.',  options

hangup
