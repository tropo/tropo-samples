#----------
#Yahoo local search app using YQL/JSON
#----------

require 'net/http'
require 'json_pure'

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

say 'Welcome to the Ruby Indian Restaurant finder.'
say 'Enter the ZIP code to find an Indian Restaurant in your area'

zip_code = get_five_digits

if digits.length == 5
  log 'zipcode entered <' + zip_code.to_s + '>'
  
  yahoo_url = 'http://query.yahooapis.com/v1/public/yql?format=json&q='
  query = "select * from local.search where zip=#{zip_code} and query='indian'"
  url = URI.encode(yahoo_url + query)
  json_data = Net::HTTP.get_response(URI.parse(url)).body
  
  if json_data
    #Convert JSON data to a Ruby hash
    indian_restaraunts = JSON.parse(json_data)
    indian_restaraunts["query"]["results"]["Result"].each do |indian_restaraunt|
      say 'The phone number for ' + indian_restaraunt["title"] + ' in ' + indian_restaraunt["City"] + 
         ' is ' + indian_restaraunt["Phone"]
    end
  else
    log 'Error getting JSON'
    log 'I am sorry, an error occurred while fetching Indian restaraunts in your area'
  end
end

say 'Thats all. Goodbye.'
hangup
