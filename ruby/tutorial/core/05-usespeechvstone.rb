# -----------
# using speech input instead of touch-tone (DTMF)
# -----------

answer

options = { :choices => 'sales, support', 
            :repeat  => 3 }
            
result = ask 'For sales, just say sales.  For support, say support.', options

if result.name == 'choice'
  case result.value
  when 'sales'
    say 'sales is not available right now.'
  when 'support'
    say 'support is currently on the other line.'
  end
end

hangup