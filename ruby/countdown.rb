answer
require 'date'
date = Date.new(2012,12,21)
date2 = Date.today
countdown = date - date2
options = {:choices => 'yes(yes, 1), no(no,2)',
		:attempts => 2,
		:timeout => 15,
		:voice => 'simon',
		:onBadChoice =>  lambda { say 'What? Let\'s try that again.', :voice => 'simon'},
		:onTimeout => lambda { say 'Oh god, is it too late? Let\'s try one more time.', :voice => 'simon'}}
		
result = ask 'Countdown to 2012 activated!  Do you want to know how long you have before disaster strikes?', options

if result.name=='choice'
	case result.value
	when 'yes'
		say countdown.to_s + 'days. Prepare yourself!', {:voice => 'simon'}
	when 'no'
		say 'I don\'t blame you, ignorance is bliss.', {:voice => 'simon'}

	end
end

hangup
	
