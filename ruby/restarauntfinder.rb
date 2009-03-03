#----------
#Yahoo local search app using YQL/JSON
#----------
require 'net/http'
require 'json'

answer 

say 'Welcome to the Ruby Restaurant finder.'

zipcode_options = { :choices     => "[5 DIGITS]",
                    :repeat      => 3,
                    :timeout     => 7,
                    :onBadChoice => lambda { say 'Invalid entry, please try again.' },
                    :onTimeout   => lambda { say 'Timeout, please try again.' },
                    :onChoice    => lambda { |zip_code_choice|
                      search_options = { :choices     => "indian('indian'), pizza('pizza', 'pizzareia'), mexican('mexican'), chinese('chinese')",
                                         :repeat      => 3,
                                         :onBadChoice => lambda { say 'Invalid entry, please try again.' },
                                         :onTimeout   => lambda { say 'Timeout, please try again.' },
                                         :onChoice    => lambda { |search_choice|
                                           log '===========>' + search_choice.inspect + '<============'
                                           yahoo_url = 'http://query.yahooapis.com/v1/public/yql?format=json&q='
                                           query = "select * from local.search where zip=#{zip_code_choice.value} and query='#{search_choice.value}'"
                                           url = URI.encode(yahoo_url + query)
                                           json_data = Net::HTTP.get_response(URI.parse(url)).body
                                           restaraunts = JSON.parse(json_data)
                                           if restaraunts
                                             restaraunts["query"]["results"]["Result"].each do |restaraunt|
                                               say 'The phone number for ' + restaraunt["Title"] + ' in ' + restaraunt["City"] + 
                                               ' is ' + restaraunt["Phone"]
                                             end
                                           else
                                             say 'I am sorry, an error occurred while fetching restaraunts in your area'
                                           end
                                         }
                      }
                      ask 'Say the type of restaraunt you would like to search for.', search_options
                    }
          }
  
ask 'Enter or say your ZIP code to find a Restaurant in your area.', zipcode_options

say 'Thats all. Goodbye.'
hangup