#==========
#Newsticker using the NYTimes API
#==========

require 'net/http'
require 'json'

api_key = 'e4d2a42f546fdbd37092fb2a2faa69f2:15:57859725' #You need to get an API key from the NYTimes here!
api_version = 'v2'
time_period = 'recent'
number_of_articles = 5
nytimes_url = "http://api.nytimes.com/svc/news/#{api_version}/all/"

json_data = Net::HTTP.get_response(URI.parse(nytimes_url)).body

options = { :choices => "recent( 1, recent), last24hours( 2, 'last twenty four hours')", 
            :repeat  => 3,
            :onEvent => lambda { |event|
                                  case event.name
                                  when 'badChoice'
                                    say 'I am sorry, I did not understand what you said.'
                                  when 'timeout'
                                    say 'I did not hear anything.'
                                  when 'choice'
                                    time_period = event.value
                                    nytimes_url = nytimes_url + "#{time_period}.json?limit=#{number_of_articles}&api_key=#{api_key}"
                                    json_data = Net::HTTP.get_response(URI.parse(nytimes_url)).body
                                    news_articles = JSON.parse(json_data)
                                    news_articles["results"].each do |news_article|
                                      say news_article["summary"]
                                    end
                                  end
                                }
          }

ask 'Welcome to the Ruby Newsticker powered by the New York Times. ' +
    'Please press one or say recent, for the most recent news. Press two or say last 24 hours, for news over the last 24 hours.', 
    options
    
hangup