# Copyright (c) 2009 - 2015 Tropo, now part of Cisco
# Released under the MIT license. See the file LICENSE
# for the complete license

#----------
#Yahoo local search app using YQL/JSON
#----------
require 'open-uri'
require 'json'

say 'Welcome to the Ruby Restaurant finder.'

zipcode_options = { :choices     => "[5 DIGITS]",
                    :attempts      => 3,
                    :timeout     => 7,
                    :onBadChoice => lambda { say 'Invalid entry, please try again.' },
                    :onTimeout   => lambda { say 'Timeout, please try again.' },
                    :onChoice    => lambda { |zip_code_choice|
                      search_options = { :choices     => "indian('indian'), pizza('pizza', 'pizzeria'), mexican('mexican'), chinese('chinese')",
                                         :attempts      => 3,
                                         :onBadChoice => lambda { say 'Invalid entry, please try again.' },
                                         :onTimeout   => lambda { say 'Timeout, please try again.' },
                                         :onChoice    => lambda { |search_choice|
                                           #Set the URI and our YQL select statement, then encode as a URI
                                           yahoo_url = 'http://query.yahooapis.com/v1/public/yql?format=json&q='
                                           query = "select * from local.search where zip=#{zip_code_choice.value} and query='#{search_choice.value}'"
                                           url = URI.encode(yahoo_url + query)

                                           #Fetch the JSON from the YQL API and convert the resulting 
                                           #JSON data to a Ruby hash
                                           restaurant = JSON.parse(open(url).read)

                                           #Speak back the results
                                           if restaurant
                                             restaurant["query"]["results"]["Result"].each do |restaurant|
                                               say 'The phone number for ' + restaurant["Title"] + ' in ' + restaurant["City"] + 
                                               ' is ' + restaurant["Phone"]
                                             end
                                           else
                                             say 'I am sorry, an error occurred while fetching restaurant in your area'
                                           end
                                         }
                      }
                      ask 'Say the type of restaurant you would like to search for.', search_options
                    }
          }
ask 'Enter or say your ZIP code to find a restaurant in your area.', zipcode_options
say 'Thats all. Goodbye.'
