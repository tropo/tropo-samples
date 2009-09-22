# -----------
# handling good choices with event handlers too
# -----------

answer

options = { :choices     => 'sales( 1, sales), support( 2, support)',
            :repeat      => 3,
            :onBadChoice => lambda { say 'I am sorry, I did not understand what you said.' },
            :onTimeout   => lambda { say 'I am sorry.  I did not hear anything.' }, 
            :onChoice    => lambda { |event| 
                                       case event.value
                                       when 'sales'
                                         say 'Ok, let me transfer you to sales.'
                                         transfer 'tel:+14129272358'
                                       when 'support'
                                         say 'Sure, let me get support. Please hold.'
                                         transfer 'tel:+14129272341'
                                       end
                                    }
          }

ask 'Hi. For sales, just say sales or press 1. For support, say support or press 2.', options

hangup
