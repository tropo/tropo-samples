# --------------------------------------------
# Reads the titles from Slashdot's RSS feed
# Created by Atul Bargaje
# See http://www.tropo.com for more info
# --------------------------------------------

import urllib2
from xml.dom import minidom, Node

answer()


say("Reading slashdot news for you")

log("*****************************************test1345*******************")
wait(1000)



url_info = urllib2.urlopen('http://rss.slashdot.org/Slashdot/slashdot')

if (url_info):
	
    xml = minidom.parse(url_info)
    if (xml):
        for node in xml.documentElement.childNodes:
            if (node.nodeName == "item"):
                for item_node in node.childNodes:
                    if (item_node.nodeName == "title"):
                        title = ""
                        for text_node in item_node.childNodes:
                            if (text_node.nodeType == node.TEXT_NODE):
                                title += text_node.nodeValue
                            if (len(title)>0):
                                log( "News Title fetched : " + title )
                                say(title)
    else:
		log( "Error getting XML " )
		Say("I am sorry, Error occured while fetching news.")
else:
	log( "Error! Getting URL" )
	Say("I am sorry, Error occured while fetching news.")
	
say("Thats all for the day. Goodbye!")

hangup()

