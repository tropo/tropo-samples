# The application allows you to Yahoo search for your favorite basketball
# team and the reads back the top 2 results, Title, Summary, URL.
# Created by Brian F

require 'net/http'
require 'rexml/document'
answer

options = { 
    'repeat'      => 2,
	  'choices'     => "Miami Heat (miami, heat, miami heat, 1), Orlando Magic (Orlando, Magic, Orlando Magic),Boston Celtics (Boston, Boston Celtics, Celtics),Philadelphia Seventy Sixers (Philadelphia, Seventy Sixers, Philadelphia Seventy Sixers),New Jersey Nets (New Jersey, Nets, New Jersey Nets), New York Knicks (New York, New York Knicks, Knicks), Toronto Raptors(Toronto, Raptors, Toronto Raptor), Cleveland Cavaliers (Cleveland, Cavaliers, Cleveland Cavaliers), Detroit Pistons (Detroit, Pistons, Detroit Pistons),  Milwaukee Bucks (Milwaukee, Bucks, Milwaukee Bucks), Chicago Bulls (Chicago, Bulls, Chicago Bulls), Indiana Pacers (Indiana Pacers, Indiana, Pacers), Atlanta Hawks (Atlanta, Hawks, Atlanta Hawks), Charlotte Hornets (Charlotte, Hornets, Charlotte Hornets), Washington Wizards (Washington, Wizards, Washington Wizards), Denver Nuggets (Denver Nuggets, Denver, Nuggets), Portland Trail Blazers (Portland, Trail Blazers, Portland Trailblazers), Utah Jazz (Utah Jazz, Utah, Jazz), Minnesota Timberwolves (Minnesota, Minnesota TimberWolves, Timberwolves), Oklahoma City Thunder (Oklahoma, Oklahoma City, Thunder), LA Lakers (LA, Lakers, Los Angelas Lakers), Phoenix Suns (Phoenix Suns, Phoenix, Suns), Golden State Warriors (Golden State, Warriors, Golden State Warriors), LA Clippers (LA, Clippers, LA Clippers), Sacramento Kings (Sacramento, Kings, Sacramento Kings), San Antonio Spurs (San Antonio, Spurs, San Antonio Spurs), Houston Rockets (Houston Rockets, Houston, Rockets), New Orleans Hornets (New Orleans, Hornets, New Orleans Hornets), Dallas Mavericks (Dallas, Mavericks, Dallas Mavericks), Memphis Grizzlies (Memphis, Grizzlies, Memphis Grizzlies)"
	  'timeout'     => 10.0, 
	  'onBadChoice' => lambda { say "I didn't get that" },
  	'onChoice'    => lambda { |event| say say "Your Search Query is #{event.value}" }
		}		
	}
event= prompt("Welcome to a Tropo Experience, please say your favorite basketball team, and Tropo powered by Ruby will return back the top 2 yahoo search results for you!!!!", options )

if event.name !="hangup"

say " Now, we are going to query Yahoo to get back the top 2 results for the #{event.value}"

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
