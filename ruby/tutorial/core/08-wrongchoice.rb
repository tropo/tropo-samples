# -----------
# handling the wrong choice
# -----------

answer

options = { :choices => 'sales(1, sales), support(2, support)' }
            
result = ask 'For sales, just say sales or press 1. For support, say support or press 2.', options

log "*"*20 + result.inspect.to_s

case result.name
when 'choice'
  case result.value
  when 'sales'
    say 'Ok, let me transfer you to sales.'
    transfer 'tel:+14129272358'
  when 'support'
    say 'Sure, let me get support.  Please hold.'
    transfer 'tel:+14129272341'
  end
when 'badChoice'
  say 'I am not sure what you wanted.  Goodbye.'
end

hangup