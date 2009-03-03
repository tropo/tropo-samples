# **************************
# RSS feed from NBA.com
# Created by Henry P.
# **************************
require 'net/http'
require 'rexml/document'

answer

wait(1000)

class NBANews

    def getFeed
        res = Net::HTTP.start('www.nba.com') {|http|
	        http.get('/rss/nba_rss.xml')
        }
        result = REXML::Document.new(res.body)
        @titles = []
        @descriptions = []
        result.elements.each('rss/channel/item/description') do |ele|
            @descriptions << ele.text
        end
        result.elements.each('rss/channel/item/title') do |ele|
            @titles << ele.text
        end
    end

    def playFeed
        say ("There are #{@titles.size} headlines.  Press 1 to move to the next headline.  Press 2 to go back to the previous headline.  Press 3 to repeat a headline.   Press 4 to listen to the full story.  Press 0 to end.")

        detail = false
        currentIndex = 0
        while currentIndex < @titles.size
            option = 'next'
            if detail == true
                result=prompt("#{@descriptions[currentIndex]}",
                {'silenceTimeout'=> 1,
                 'choices'=> "next(1, next), previous(2, previous), repeat(3, repeat), detail(4, detail), end(0, end)",
                 'maxTime'=>30,
                 'timeout'=>1.203456789,
                 'onChoice'=>lambda { |event| option = event.value },
                 'onEvent'=>lambda { |event|
                      event.onTimeout( lambda { option = 'next' } )
                      event.onHangup( lambda { option = 'end' } )
                      event.onBadChoice( lambda { say "bad choice" } )}
                })
            else
                result=prompt("#{@titles[currentIndex]}",
                {'silenceTimeout'=> 1,
                 'choices'=> "next(1, next), previous(2, previous), repeat(3, repeat), detail(4, detail), end(0, end)",
                 'maxTime'=>30,
                 'timeout'=>1.203456789,
                 'onChoice'=>lambda { |event| option = event.value },
                 'onEvent'=>lambda { |event|
                      event.onTimeout( lambda { option = 'next'} )
                      event.onHangup( lambda { option = 'end' } )
                      event.onBadChoice( lambda { say "bad choice" } )}
                })
            end
            
            if result.name == 'hangup'
                break
            end
            
            case option
                when 'next'
                    # next - skip to the next headline
                    currentIndex += 1
                    detail = false
                when 'previous'
                    # previous - go back to the previous headline
                    if currentIndex > 0
                        currentIndex -= 1
                    end
                    detail = false
                when 'detail'
                    # detail - play detail headline
                    detail = true
                when 'repeat'
                    # repeat - repeat the headline
                when 'end'
                    break
            else
                #  default - break
                break
            end
            
            wait(1000)
        end
    end
end    

say("Welcome to the NBA Headline News.")

say("Please wait while we retrieve the latest headline news for #{Time.now.strftime("%m/%d/%y")}")

f1 = NBANews.new()
f1.getFeed
f1.playFeed

hangup
