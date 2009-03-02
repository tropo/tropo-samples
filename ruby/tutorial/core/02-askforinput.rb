# -----------
# asking for input
# -----------

answer

options = { :choices => '1,2' }

result = ask 'Hi. For sales, press 1. For support, press 2.', options

if result.name == 'choice'
  case result.value
  when '1'
    say 'sales is not available right now.'
  when '2'
	  say 'support is currently on the other line.'
	end 
end

hangup