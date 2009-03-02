#----------
#Yahoo weather app using YQL/JSON
#----------

require 'net/http'
require 'json'

def get_five_digits
  digits = nil
  done = false
  while not done do
    event = ask '', { :choices => '0,1,2,3,4,5,6,7,8,9', :timeout => 5 }
    if event.name == 'choice'
      digits = event.value
    else
      done = true
    end
    
    if digits.length == 5
      done = true
    end
  end
  return digits
end

say 'Welcome to the Ruby Yahoo weather reader'
say 'Enter the ZIP code for a weather check'

zip_code = get_five_digits

if digits.length == 5
  log 'zipcode entered <' + zip_code.to_s + '>'
  
  yahoo_url = 'http://query.yahooapis.com/v1/public/yql?format=json&q='
  query = "SELECT * FROM weather.forecast WHERE location = " + zip_code.to_s
  url = URI.encode(yahoo_url + query)
  json_data = Net::HTTP.get_response(URI.parse(url)).body
  
  if json_data
    #Convert JSON data to a Ruby hash
    weather_data = JSON.parse(json_data)
    #Get the weather channel details and throw them into a hash
    weather_results = weather_data["query"]["results"]["channel"]
    
    say weather_results["title"]
    say "Wind chill is #{weather_results["wind"]["chill"]} degrees, " + 
        "wind speed is #{weather_results["wind"]["speed"]}", +
        "wind direction is #{weather_results["wind"]["direction"]}."
    say "Conditions are #{weather_results["conditions"]["text"]}."
    say "The forecast is #{weather_results["forecast"]["text"]}, " +
        "with a high of #{weather_results["forecast"]["high"]} degrees, " +
        "and a low of #{weather_results["forecast"]["low"]}."
  else
    log 'Error getting JSON'
    log 'I am sorry, an error occurred while fetching the weather'
  end
end

say 'Thats all. Goodbye.'
hangup
  
