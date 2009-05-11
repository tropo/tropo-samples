# Ruby ASR Weather for Tropo
# Copyright 2009 Jonathan Rudenberg
# Licensed under the MIT License
#
# Requires a Yahoo! App ID and WeatherBug API Key
# http://developer.yahoo.com/maps/rest/V1/geocode.html
# http://weather.weatherbug.com/desktop-weather/api.html
#
# Try it out at any of these numbers:
# POTS: 1-312-957-8992
 
require 'rexml/document'
require 'open-uri'
 
DAYS = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
 
## Helper Classes
class ReverseLookup
  attr_accessor :npa, :nxx, :provider, :url, :city, :state
  
  TELCODATA_URL = "http://www.telcodata.us/query/queryexchangexml.html?"
  
  def initialize(number)
    @npa = number.to_s[0,3]
    @nxx = number.to_s[3,3]
    
    @url = TELCODATA_URL + "npa=#{@npa}&nxx=#{@nxx}"
    
    lookup
  end
  
  def lookup
    @doc = REXML::Document.new(open(@url))
    
    @city = @doc.elements['root/exchangedata/ratecenter'].text
    @state = @doc.elements['root/exchangedata/state'].text
    
    log "Reverse Lookup Results: #{@city}, #{@state}"
  end
end
 
 
 
class Geocoder
  attr_reader :longitude, :latitude, :country
  
  APP_ID = '' # Get yours at http://developer.yahoo.com/maps/rest/V1/geocode.html
  BASE_URL = "http://local.yahooapis.com/MapsService/V1/geocode?appid=#{APP_ID}&"
  
  def initialize(location)
    @url = BASE_URL + "location=#{location}&"
    @url.gsub!(/ /, '%20')
    
    geocode
  end
  
  def geocode
    @doc = REXML::Document.new(open(@url))
    
    @latitude = @doc.elements['ResultSet/Result/Latitude'].text
    @longitude = @doc.elements['ResultSet/Result/Longitude'].text
    @country = @doc.elements['ResultSet/Result/Country'].text
    
    log "Geocoder Results: latitude => #{@latitude}, longitude => #{@longitude}"
  end
end
 
 
 
module Weather
  A_CODE = '' # Get yours at http://weather.weatherbug.com/desktop-weather/api.html
  
  class Forecast
    attr_reader :city, :country, :days
 
    BASE_URL = "http://api.wxbug.net/getForecastRSS.aspx?ACode=#{A_CODE}&OutputType=1&"
  
    def initialize(latitude, longitude, country = 'US')
      unit_type = country == 'US' ? 'UnitType=0&' : 'UnitType=1&' # imperial or metric
      @url = BASE_URL + unit_type + "lat=#{latitude}&long=#{longitude}&"
      @days = {}
      
      get
    end
  
    def get
      @doc = REXML::Document.new(open(@url))
    
      @city = @doc.elements['aws:weather/aws:forecasts/aws:location/aws:city'].text
      @country = @doc.elements['aws:weather/aws:forecasts/aws:location/aws:country'].text rescue 'USA'
    
      @doc.elements.each('aws:weather/aws:forecasts/aws:forecast') do |forecast|
        @days[forecast.elements['aws:title'].text] = {
          :condition => forecast.elements['aws:short-prediction'].text,
          :prediction => forecast.elements['aws:prediction'].text.gsub(/^ /, '').gsub(/\&deg\;(C|F)?/, ' degrees'),
          :high => forecast.elements['aws:high'].text.to_i,
          :low => forecast.elements['aws:low'].text.to_i
        }
      end
      
      @days.each_with_index do |forecast, i|
        day = forecast[0] # hash key
        forecast = forecast[1] # hash
        
        forecast[:prediction].gsub!(/( |[ESW])N( |\.|[NESW])/, '\1 north \2')
        forecast[:prediction].gsub!(/( |[NSW])E( |\.|[NESW])/, '\1 east \2')
        forecast[:prediction].gsub!(/( |[NEW])S( |\.|[NESW])/, '\1 south \2')
        forecast[:prediction].gsub!(/( |[NSE])W( |\.|[NESW])/, '\1 west \2')
        forecast[:prediction].gsub!(/mph/, 'miles per hour')
        
        forecast[:text] = "#{day}, #{forecast[:prediction]} Low of #{forecast[:low]} degrees."
      end
 
    end
    
    def from(weekday)
      forecasts = []
      (0..6).each do |n|
        day_index = DAYS.index(weekday) + n
        day_index = day_index - 7 if day_index > 6
        
        forecasts << @days[DAYS[day_index]][:text]
        
        break if Time.now.wday == day_index + 1
      end
      
      return forecasts.join(' ')
    end
    
    def read(day = DAYS[Time.now.wday])
      prompt_options = { :beep => false,
                         :choices => DAYS.join(", "),
                         :timeout => 2,
                         :onEvent => lambda { |event|
                           case event.name.to_sym
                           when :choice
                             read event.value
                           when :badChoice
                             say "I'm sorry, I didn't understand what you said"
                           end
                         }
                       }
      prompt from(day), prompt_options
    end
  end
end
 
 
 
answer
 
reverse = ReverseLookup.new($currentCall.callerID)
geocoder = Geocoder.new("#{reverse.city}, #{reverse.state}")
forecast = Weather::Forecast.new(geocoder.latitude, geocoder.longitude, geocoder.country)
 
 
zip_prompt_options = { :beep => false,
                       :choices => '[5 DIGITS], [6 DIGITS]',
                       :timeout => 2,
                       :onEvent => lambda { |event|
                         case event.name.to_sym
                         when :choice
                           if event.value.length == 6
                             reverse = ReverseLookup.new(event.value)
                             geocoder = Geocoder.new("#{reverse.city}, #{reverse.state}")
                           else
                             geocoder = Geocoder.new(event.value)
                           end
                           forecast = Weather::Forecast.new(geocoder.latitude, geocoder.longitude, geocoder.country)
                           say "Here is the weather for #{forecast.city}"
                         when :badChoice
                           say "I'm sorry, I didn't understand what you said"
                         end } }
 
prompt "I have the weather forecast for #{forecast.city}, say a zip code or area code and prefix if you want a different city.", zip_prompt_options
say "You may skip by saying a day at any time."
forecast.read
say "This concludes the weather forecast for #{forecast.city}"
 
hangup
