# --------------------------------------------
# Yahoo weather app
# See http://www.tropo.com for more info
# --------------------------------------------

import urllib2
from xml.dom import minidom, Node

def getFiveDigits() :
    digits = ''
    bDone  = False
    while not bDone :
        event = ask( "", { 'choices' : '0,1,2,3,4,5,6,7,8,9', 'timeout':5 })
        if event.name == 'choice' :
            digits += event.value
        else :
            bDone = True
        if len( digits ) == 5 :
            bDone = True
    return digits

answer()

zipCode = ''
say( "Welcome to the python Yahoo weather reader" )
say( "Enter the ZIP code for a weather check" )
zipCode = getFiveDigits()
#result = ask( "Enter the ZIP code for a weather check", { 'choices':"5 DIGITS", 'timeout':10 })
#if result.name == 'choice' :
#    zipCode = result.value
if len( zipCode ) == 5 :
    log( "zipCode <" + zipCode + ">" )
    urlRead = urllib2.urlopen('http://weather.yahooapis.com/forecastrss?p=' + zipCode + '&u=f')
    if urlRead :
        xml = minidom.parse( urlRead )
        if xml :
            for node in xml.documentElement.childNodes :
                if node.nodeName == "channel" :
                    log( "ABCD got a channel" )
                    for item_node in node.childNodes :
                        if item_node.nodeName == "description" :
                            description = ""
                            for text_node in item_node.childNodes:
                                if text_node.nodeType == node.TEXT_NODE :
                                    log( "ABCDEF got a text node <" + text_node.nodeValue + ">" )
                                    description += text_node.nodeValue
                                if len( description ) > 0:
                                    log( "ABCDEF Weather description < " + description + ">" )
                                    say( description )
                        if item_node.nodeName == "yweather:units" :
                            log( "ABCDEF  at yweather.units" )
                            weatherUnits = ""
                            for text_node in item_node.childNodes:
                                log( "ABCDEF got a weather unit name <" + text_node.nodeName + ">" )
                        if item_node.nodeName == "item" :
                            item = ""
                            for weatherItem_node in item_node.childNodes:
                                if weatherItem_node.nodeName == "title" :
                                    weatherTitle = ""
                                    for weatherText_node in weatherItem_node.childNodes :
                                        log( "ABCDEFG - item - got a weather title item <" + weatherText_node.nodeValue + ">" )
                                        weatherTitle += weatherText_node.nodeValue
                                    if len( weatherTitle ) > 0 :
                                        log( "WEATHER TITLE " + weatherTitle )
                                        say( weatherTitle )
                                if weatherItem_node.nodeName == "yweather:condition" :
                                    weatherCondition = weatherItem_node.getAttribute( 'temp' )
                                    log( "WEATHER CONDITION - temp - " + weatherCondition )
                                    if len( weatherCondition ) > 0 :
                                        say( "Temperature: " + weatherCondition + " degrees Fahrenheit" )
                                    weatherCondition = weatherItem_node.getAttribute( 'text' )
                                    log( "WEATHER CONDITION - text - " + weatherCondition )
                                    if len( weatherCondition ) > 0 :
                                        say( weatherCondition )
    else :
        log( "Error getting XML " )
        say( "I am sorry, Error occured while fetching weather." )

say( "Thats all. Goodbye!" )

hangup()
