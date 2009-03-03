#----------
#Yahoo weather app using YQL/JSON
#----------
require 'net/http'
require 'json'

answer
say 'Welcome to the Ruby Yahoo weather reader'

options = { :choices     => "[5 DIGITS]",
            :repeat      => 3,
            :timeout     => 7,
            :onBadChoice => lambda { say 'Invalid entry, please try again.' },
            :onTimeout   => lambda { say 'Timeout, please try again.' },
            :onChoice    => lambda { |choice|
              yahoo_url = 'http://query.yahooapis.com/v1/public/yql?format=json&q='
              query = "SELECT * FROM weather.forecast WHERE location = " + choice.value
              url = URI.encode(yahoo_url + query)
              json_data = Net::HTTP.get_response(URI.parse(url)).body
              #Convert JSON data to a Ruby hash
              weather_data = JSON.parse(json_data)
              #Get the weather channel details and throw them into a hash
              weather_results = weather_data["query"]["results"]["channel"]
              say weather_results["description"]
              log weather_results.inspect
              say "The wind chill is #{weather_results["wind"]["chill"]} degrees, " + 
                  "the wind speed is #{weather_results["wind"]["speed"]}" 
              say "The forecast is #{weather_results["item"]["forecast"][0]["text"]}, " +
                  "with a high of #{weather_results["item"]["forecast"][0]["high"]} degrees, " +
                  "and a low of #{weather_results["item"]["forecast"][0]["low"]} degrees."
                }
          }

ask 'Enter the ZIP code for a weather check', options
say 'Thats all. Goodbye.'
hangup
  
