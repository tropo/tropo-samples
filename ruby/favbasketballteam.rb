# Copyright (c) 2009 - 2015 Tropo, now part of Cisco
# Released under the MIT license. See the file LICENSE
# for the complete license

# The application allows you to Yahoo search for your favorite basketball
# team and the reads back the top 2 results, Title, Summary, URL.

require 'net/http'
require 'rexml/document'
answer

options = { 
    'repeat'=>2,
    'choices'=>"Miami Heat (miami, heat, miami heat, 1),\n Orlando Magic (Orlando, Magic, Orlando Magic),\nBoston Celtics (Boston, Boston Celtics, Celtics),\nPhiladelphia Seventy Sixers (Philadelphia, Seventy Sixers, Philadelphia Seventy Sixers),\nNew Jersey Nets (New Jersey, Nets, New Jersey Nets),\n New York Knicks (New York, New York Knicks, Knicks),\n Toronto Raptors(Toronto, Raptors, Toronto Raptor),\n Cleveland Cavaliers (Cleveland, Cavaliers, Cleveland Cavaliers),\n Detroit Pistons (Detroit, Pistons, Detroit Pistons), \n Milwaukee Bucks (Milwaukee, Bucks, Milwaukee Bucks),\n Chicago Bulls (Chicago, Bulls, Chicago Bulls),\n Indiana Pacers (Indiana Pacers, Indiana, Pacers),\n Atlanta Hawks (Atlanta, Hawks, Atlanta Hawks),\n Charlotte Hornets (Charlotte, Hornets, Charlotte Hornets),\n Washington Wizards (Washington, Wizards, Washington Wizards),\n Denver Nuggets (Denver Nuggets, Denver, Nuggets),\n Portland Trail Blazers (Portland, Trail Blazers, Portland Trailblazers),\n Utah Jazz (Utah Jazz, Utah, Jazz),\n Minnesota Timberwolves (Minnesota, Minnesota TimberWolves, Timberwolves),\n Oklahoma City Thunder (Oklahoma, Oklahoma City, Thunder),\n LA Lakers (LA, Lakers, Los Angelas Lakers),\n Phoenix Suns (Phoenix Suns, Phoenix, Suns),\n Golden State Warriors (Golden State, Warriors, Golden State Warriors),\n LA Clippers (LA, Clippers, LA Clippers),\n Sacramento Kings (Sacramento, Kings, Sacramento Kings),\n San Antonio Spurs (San Antonio, Spurs, San Antonio Spurs),\n Houston Rockets (Houston Rockets, Houston, Rockets),\n New Orleans Hornets (New Orleans, Hornets, New Orleans Hornets),\n Dallas Mavericks (Dallas, Mavericks, Dallas Mavericks),\n Memphis Grizzlies (Memphis, Grizzlies, Memphis Grizzlies),\n", 'timeout'=>10.0, 
    'onBadChoice' => lambda { say "I didn't get that" },
    'onChoice'=>lambda { | event |
   event.onChoice( "Miami Heat", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Orlando Magic", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Boston Celtics", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "New Jersey Nets", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "New York Knicks", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Toronto Raptors", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Cleveland Cavaliers", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Detroit Pistons", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Milwaukee Bucks", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Chicago Bulls", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Indiana Pacers", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Atlanta Hawks", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Charlotte Hornets", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Washington Wizards", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Denver Nuggets", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Portland Trail Blazers", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Utah Jazz", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Minnesota Timberwolves", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Oklahoma City Thunder", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "LA Lakers", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Golden State Warriors", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "LA Clippers", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Sacramento Kings", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "San Antonio Spurs", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Phoenix Suns", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Houston Rockets", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "New Orleans Hornets", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Dallas Mavericks", lambda { say "Your Search Query is [#{event.value}]" } )
    event.onChoice( "Memphis Grizzlies", lambda { say "Your Search Query is [#{event.value}]" } )
            }        
          }
event= ask("Welcome to a Tropo Experience, please say your favorite basketball team, and Tropo powered by Ruby will return back the top 2 yahoo search results for you!!!!", options )

if event.name !="hangup"

say " Now, we are going to query Yahoo to get back the top 2 results for the   [#{event.value}]"

APPLICATION_ID = 'ighWr_vV34GjUPjkeAWABHDmp07_YOsbpzm812TY9Dq_AikP8tIfUaucY5QiKQ3.HscS7Y8-'
YAHOO_WEB_SERVICE_SEARCH_URL = 'http://search.yahooapis.com/WebSearchService/V1/webSearch'
query         = "[#{event.value}]"
results_limit = 2
url = "#{YAHOO_WEB_SERVICE_SEARCH_URL}?appid=#{APPLICATION_ID}&query=#{URI.encode(query)}&results=#{results_limit}"

begin
 xml_result_set = Net::HTTP.get_response(URI.parse(url))
# xml_result_set = open(url)
rescue Exception => e
 puts 'Connection error: ' + e.message
 say "error occured during web request"
end

result_set = REXML::Document.new(xml_result_set.body)
titles    = Array.new
summaries = Array.new
links     = Array.new

result_set.elements.each('ResultSet/Result/Title') do | element | titles << element.text
end
result_set.elements.each('ResultSet/Result/Summary') do | element | summaries << element.text
end
result_set.elements.each('ResultSet/Result/Url') do | element | links << element.text
end

titles.each_with_index do | title, index |
say"Title: #{title}"
say "Summary: #{summaries[index]}"
say "Links: #{links[index].gsub!(/(http:\/\/)/){}}"

end

say "The results are now complete, I hope you enjoyed your tropo experience!"
hangup
else
hangup
end