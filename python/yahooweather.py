import urllib2
from xml.dom import minidom, Node


answer()

say( "Welcome to the python Yahoo weather reader" )
result = ask( "Enter the ZIP code for a weather check", { 'choices' : "[5 DIGITS]" })
if result.name == 'choice' :
    log( "zipCode <" + result.value + ">" )
    urlRead = urllib2.urlopen('http://weather.yahooapis.com/forecastrss?p=' + result.value + '&u=f')
    if urlRead :
        xml = minidom.parse( urlRead )
        if xml :
            for node in xml.documentElement.childNodes :
                if node.nodeName == "channel" :
                    for item_node in node.childNodes :
                        if item_node.nodeName == "description" :
                            description = ""
                            for text_node in item_node.childNodes:
                                if text_node.nodeType == node.TEXT_NODE :
                                    description += text_node.nodeValue
                                if len( description ) > 0:
                                    say( description )
                        if item_node.nodeName == "item" :
                            item = ""
                            for weatherItem_node in item_node.childNodes:
                                if weatherItem_node.nodeName == "title" :
                                    weatherTitle = ""
                                    for weatherText_node in weatherItem_node.childNodes :
                                        weatherTitle += weatherText_node.nodeValue
                                    if len( weatherTitle ) > 0 :
                                        say( weatherTitle )
                                if weatherItem_node.nodeName == "yweather:condition" :
                                    weatherCondition = weatherItem_node.getAttribute( 'temp' )
                                    if len( weatherCondition ) > 0 :
                                        say( "Temperature: " + weatherCondition + " degrees Fahrenheit" )
                                    weatherCondition = weatherItem_node.getAttribute( 'text' )
                                    if len( weatherCondition ) > 0 :
                                        say( weatherCondition )
    else :
        log( "Error getting XML " )
        say( "I am sorry, Error occured while fetching weather." )

say( "Thats all. Goodbye!" )

hangup()

