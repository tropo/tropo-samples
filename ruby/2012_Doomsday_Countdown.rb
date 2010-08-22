VOICE = 'simon' 

#finding the user's area code and subtracting the appropriate hours from serverside GMT

TIME_ZONE_HASH = {'242'=>'atlantic','246'=>'atlantic','264'=>'atlantic','268'=>'atlantic','284'=>'atlantic','340'=>'atlantic','441'=>'atlantic','473'=>'atlantic','506'=>'atlantic','664'=>'atlantic','758'=>'atlantic','767'=>'atlantic','784'=>'atlantic','809'=>'atlantic','829'=>'atlantic','868'=>'atlantic','869'=>'atlantic','902'=>'atlantic','201'=>'eastern','202'=>'eastern','203'=>'eastern','207'=>'eastern','212'=>'eastern','215'=>'eastern','216'=>'eastern','226'=>'eastern','229'=>'eastern','231'=>'eastern','234'=>'eastern','239'=>'eastern','240'=>'eastern','248'=>'eastern','252'=>'eastern','260'=>'eastern','267'=>'eastern','269'=>'eastern','276'=>'eastern','289'=>'eastern','301'=>'eastern','302'=>'eastern','304'=>'eastern','305'=>'eastern','313'=>'eastern','315'=>'eastern','317'=>'eastern','321'=>'eastern','330'=>'eastern','336'=>'eastern','339'=>'eastern','345'=>'eastern','347'=>'eastern','351'=>'eastern','352'=>'eastern','386'=>'eastern','401'=>'eastern','404'=>'eastern','407'=>'eastern','410'=>'eastern','412'=>'eastern','413'=>'eastern','416'=>'eastern','418'=>'eastern','419'=>'eastern','423'=>'eastern','434'=>'eastern','438'=>'eastern','440'=>'eastern','443'=>'eastern','450'=>'eastern','470'=>'eastern','475'=>'eastern','478'=>'eastern','484'=>'eastern','502'=>'eastern','508'=>'eastern','513'=>'eastern','514'=>'eastern','516'=>'eastern','517'=>'eastern','518'=>'eastern','519'=>'eastern','540'=>'eastern','551'=>'eastern','561'=>'eastern','567'=>'eastern','570'=>'eastern','571'=>'eastern','574'=>'eastern','585'=>'eastern','586'=>'eastern','603'=>'eastern','606'=>'eastern','607'=>'eastern','609'=>'eastern','610'=>'eastern','613'=>'eastern','614'=>'eastern','616'=>'eastern','617'=>'eastern','631'=>'eastern','646'=>'eastern','647'=>'eastern','649'=>'eastern','678'=>'eastern','703'=>'eastern','704'=>'eastern','705'=>'eastern','706'=>'eastern','716'=>'eastern','717'=>'eastern','718'=>'eastern','724'=>'eastern','727'=>'eastern','732'=>'eastern','734'=>'eastern','740'=>'eastern','754'=>'eastern','757'=>'eastern','762'=>'eastern','765'=>'eastern','770'=>'eastern','772'=>'eastern','774'=>'eastern','781'=>'eastern','786'=>'eastern','787'=>'eastern','802'=>'eastern','803'=>'eastern','804'=>'eastern','807'=>'eastern','810'=>'eastern','812'=>'eastern','813'=>'eastern','814'=>'eastern','819'=>'eastern','828'=>'eastern','835'=>'eastern','843'=>'eastern','845'=>'eastern','848'=>'eastern','850'=>'eastern','856'=>'eastern','857'=>'eastern','859'=>'eastern','860'=>'eastern','862'=>'eastern','863'=>'eastern','864'=>'eastern','865'=>'eastern','876'=>'eastern','878'=>'eastern','904'=>'eastern','905'=>'eastern','906'=>'eastern','908'=>'eastern','910'=>'eastern','912'=>'eastern','914'=>'eastern','917'=>'eastern','919'=>'eastern','931'=>'eastern','937'=>'eastern','939'=>'eastern','941'=>'eastern','947'=>'eastern','954'=>'eastern','959'=>'eastern','973'=>'eastern','978'=>'eastern','980'=>'eastern','989'=>'eastern','204'=>'central','205'=>'central','210'=>'central','214'=>'central','217'=>'central','218'=>'central','219'=>'central','224'=>'central','225'=>'central','228'=>'central','251'=>'central','254'=>'central','256'=>'central','262'=>'central','270'=>'central','281'=>'central','306'=>'central','308'=>'central','309'=>'central','312'=>'central','314'=>'central','316'=>'central','318'=>'central','319'=>'central','320'=>'central','325'=>'central','331'=>'central','334'=>'central','337'=>'central','361'=>'central','402'=>'central','405'=>'central','409'=>'central','414'=>'central','417'=>'central','430'=>'central','432'=>'central','469'=>'central','479'=>'central','501'=>'central','504'=>'central','507'=>'central','512'=>'central','515'=>'central','563'=>'central','573'=>'central','580'=>'central','601'=>'central','605'=>'central','608'=>'central','612'=>'central','615'=>'central','612'=>'central','620'=>'central','630'=>'central','636'=>'central','641'=>'central','651'=>'central','660'=>'central','662'=>'central','682'=>'central','708'=>'central','712'=>'central','713'=>'central','715'=>'central','731'=>'central','763'=>'central','769'=>'central','773'=>'central','779'=>'central','806'=>'central','815'=>'central','816'=>'central','817'=>'central','830'=>'central','832'=>'central','847'=>'central','870'=>'central','901'=>'central','903'=>'central','913'=>'central','918'=>'central','920'=>'central','936'=>'central','940'=>'central','952'=>'central','956'=>'central','972'=>'central','979'=>'central','985'=>'central','208'=>'mountain','250'=>'mountain','303'=>'mountain','307'=>'mountain','385'=>'mountain','403'=>'mountain','406'=>'mountain','435'=>'mountain','480'=>'mountain','505'=>'mountain','520'=>'mountain','541'=>'mountain','575'=>'mountain','602'=>'mountain','623'=>'mountain','701'=>'mountain','719'=>'mountain','720'=>'mountain','780'=>'mountain','785'=>'mountain','801'=>'mountain','915'=>'mountain','928'=>'mountain','970'=>'mountain','206'=>'pacific','209'=>'pacific','213'=>'pacific','253'=>'pacific','310'=>'pacific','323'=>'pacific','360'=>'pacific','408'=>'pacific','415'=>'pacific','424'=>'pacific','425'=>'pacific','503'=>'pacific','509'=>'pacific','510'=>'pacific','530'=>'pacific','559'=>'pacific','562'=>'pacific','604'=>'pacific','619'=>'pacific','626'=>'pacific','650'=>'pacific','661'=>'pacific','702'=>'pacific','707'=>'pacific','714'=>'pacific','760'=>'pacific','775'=>'pacific','778'=>'pacific','805'=>'pacific','818'=>'pacific','831'=>'pacific','858'=>'pacific','909'=>'pacific','916'=>'pacific','925'=>'pacific','949'=>'pacific','951'=>'pacific','971'=>'pacific','907'=>'alaskan','808'=>'huh why e'}

TIME_ZONE_NAME = { 'atlantic' => { :gmt_offset => 3 },
                   'eastern'  => { :gmt_offset => 4 },
                   'central'  => { :gmt_offset => 5 },
                   'mountain' => { :gmt_offset => 6 },
                   'pacific'  => { :gmt_offset => 7 },
                   'alaskan'  => { :gmt_offset => 8 },
                   'huh why e' => { :gmt_offset => 9 } }         

DEFAULT_OPTIONS = { :attempts    => 2,
                    :timeout     => 15,
                    :voice       => VOICE,
                    :onBadChoice => lambda { |event|
                      
                      case event.attempt
                      when 1
                        say "Sorry, didn't catch that. This time in English.", { :voice => VOICE }
                      when 2
                        say "Sorry, I still don't understand. Please give us a call back if you're still alive.", { :voice => VOICE }
                        hangup
                      end
                      
                    },  
                    :onTimeout    => lambda { |event|
                      
                        case event.attempt
                        when 1
                          say "Sorry, couldn't hear you. Let's try that again, this time with more spirit!", { :voice => VOICE }
                        when 2
                          say "Sorry, still couldn't hear you. Please give us a call back if you're still alive.", { :voice => VOICE }
                          hangup
                        end
                        
                    }
                  }

# Method to calculate the time left from current time based on an offset for a particular timezone
def calculate_time_left(timezone)
  # Set the default to Eastern time if not available
  calculated_time = {}
  
  # Calculate the difference between now and then
  end_time = Time.local(2012, 12, 21, 0, 0, 0)
  start_time = Time.now - (60*60*TIME_ZONE_NAME[timezone][:gmt_offset])
  difference = end_time - start_time

  #calculating the days, hours, minutes and seconds out of the initial large seconds value generated by 'difference', then dropping the values after the decimal
  calculated_time[:days] = (difference / (60*60*24)).to_i
  days_remainder = (difference % (60*60*24)).to_i
  calculated_time[:hours] = (days_remainder / (60*60)).to_i
  hours_remainder = (days_remainder % (60 * 60)).to_i
  calculated_time[:minutes] = (hours_remainder / 60).to_i
  calculated_time[:seconds] = (hours_remainder % 60).to_i
  calculated_time
end

# This takes the callerID and uses the time_zone_offset_hash to get the timezone
if TIME_ZONE_HASH[$currentCall.callerID[0,3]]
  timezone = TIME_ZONE_HASH[$currentCall.callerID[0,3]] 
else 
  unknown_timezone = true
  timezone = 'eastern'
end

answer

# Ask if they want to hear the countdown
options = DEFAULT_OPTIONS.merge!({ :choices => 'yes(yes, 1), no(no,2)' })
result = ask '' + 'Countdown to 2012 activated!  Do you want to know how long you have before disaster strikes?', options
if result.name == 'choice'
  case result.value
  when 'yes'
    calculated_time = calculate_time_left(timezone)
    text = calculated_time[:days].to_s + 'days, ' + 
           calculated_time[:hours].to_s + 'hours, ' + 
           calculated_time[:minutes].to_s + 'minutes and, ' + 
           calculated_time[:seconds].to_s + 'seconds '
    
    if unknown_timezone
      text += 'eastern time. Since we couldn\'t figure out your timezone based on your phone number, we picked eastern time.'
    else
      text += timezone + ' time.'
    end
    
    say text, { :voice => VOICE }
  when 'no'
    say 'Fine, I didn\'t want to tell you anyways.', { :voice => VOICE }
    hangup
    abort
  end
end

loop do

  # Ask if they want to hear based on a different timezone
  options = DEFAULT_OPTIONS.merge!({ :choices => 'yes(yes, 1), no(no,2)' })
  result = ask '' + 'Would you like to hear the countdown using a different time zone?', options
  if result.name == 'choice'
    case result.value
    when 'yes'
      ask 'Okay then.', { :voice=> VOICE }
    when 'no'
      say 'I don\'t blame you.  Keep your head up, you poor soul.', { :voice => VOICE }
      hangup
      abort
    end
  end
  
  # Ask the timezone they want to hear it from
  options = DEFAULT_OPTIONS.merge!({ :choices => 'atlantic, eastern, central, mountain, pacific, alaskan, huh why e' })
  result = ask '' + 'Which time zone would you prefer? Please say atlantic, eastern, central, mountain, pacific, alaskan or huh why e.', options
  if result.name == 'choice'
    calculated_time = calculate_time_left(result.value)
    
    say calculated_time[:days].to_s    + 'days,' + 
        calculated_time[:hours].to_s   + 'hours,' + 
        calculated_time[:minutes].to_s + 'minutes and,' + 
        calculated_time[:seconds].to_s + 'seconds' + 
        result.value + ' time.', { :voice => VOICE }
  end
  
end

hangup