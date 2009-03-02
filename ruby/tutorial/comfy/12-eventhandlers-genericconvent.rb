# -----------
# using the generic onEvent handler instead
# -----------

answer

prompt  = 'Hi. For sales, just say sales or press 1. For support, say support or press 2.'
choices = 'sales( 1, sales), support( 2, support)'

ask prompt, :choices => choices, :repeat => 3 do |link|

  link.on :choice do |event|
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
  
  link.on :bad_choice do |event|
    say 'I am sorry, I did not understand what you said.'
  end
  
  link.on :timeout do |event|
    say 'Hm. I did not hear anything.'
  end

end

hangup
