answer
require 'date'
date = Date.new(2012,12,21)
date2 = Date.today
countdown = date - date2
options = {:choices => 'yes(yes, 1), no(no,2)',
		:attempts => 1,
		:timeout => 15,
		:voice => 'simon',
		:onBadChoice =>  lambda { say 'What you say?'},
		:onTimeout => lambda { say 'Oh god, its too late!'}}
		
result = ask 'Countdown activated!  Do you want to know how long you have before disaster strikes?', options

if result.name=='choice'
	case result.value
	when 'yes'
		say countdown.to_s + 'days. Prepare yourself!', {:voice => 'simon'}
	when 'no'
		say 'I don\'t blame you.', {:voice => 'simon'}

	end
end

hangup
	
