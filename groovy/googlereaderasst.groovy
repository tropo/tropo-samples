/*
 * Google Reader Assistant application 
 * 
 * Reads your Google Reader stream over the phone. Run it on http://sphere.tropo.com. 
 * NOTE: Insert your own Google username/password below before running.
 * 
 * Copyright 2009 Alex Agranovsky (alex@voxeo.com)
 * 
 *
 */
 
 
import org.xml.sax.EntityResolver;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.*;

import java.util.regex.*


//**********************************************************************************
//    VARIABLES
//**********************************************************************************
class GReaderItem extends Object {
	String gLinkToItem;
	String gItemTitle;
	String gItemFeed;
	String gFeedLink;
	
	// only populated on request
	String gStarLink;
	String gDetailsText;
};

class MyDTDHandler implements DTDHandler {
 	void 	notationDecl(String name, String publicId, String systemId)
 	{
   	   println "notationDecl " + name + ", " + publicId + ", " + systemId;
 	}
	void 	unparsedEntityDecl(String name, String publicId, String systemId, String notationName) 
	{
   	   println "unparsedEntityDecl " + name + ", " + publicId + ", " + systemId + ", " + notationName;
	}
}

// overload entity resolver, so we don't fetch dozens of them with every new page
class MyEntityResolver implements EntityResolver {
	Map gEntities = [:];

   	public InputSource resolveEntity (String publicId, String systemId)
   	{
   		String sEmpty = "";
		try {
/*		if for some reason we need the DTDs, the initial fetch will be very long
			if ( gEntities[publicId] == null ) {			
				def url = new URL(systemId)
				if ( url.getProtocol() == "file" ) {
					return null;
				}
				
				def connection = url.openConnection()		
				connection.setRequestProperty("User-Agent", "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.6) Gecko/2009011912 Firefox/3.0.6")    
				connection.connect()
			
				if (connection.responseCode == 200 || connection.responseCode == 201) {
					gEntities[publicId] = connection.content.text
					return null;
				} else {
					println "resolveEntity (fetching failed)" + publicId + ", " + systemId;
					return null
				}
			}
			return new InputSource(new StringBufferInputStream(gEntities[publicId]));
*/			
			return new InputSource(new StringBufferInputStream(sEmpty));
		} catch (Exception e) {
			println "resolveEntity (fetching failed 2)" + publicId + ", " + systemId + ", " + e.getMessage();
		}
		return null  	
   	}
}

class GReaderState extends Object {
	String 		gUsername = "ENTER USERNAME";
	String 		gPassword = "ENTER PASSWORD";
	String 		gSID = "";
	String 		gLSID = "";
	String 		gAuth = "";
	String 		gLastError = "";
	String 		gLastRetrievedPage = "";
	ArrayList	gPageItemsSet;
	String 		gNextPageURI = "http://www.google.com/reader/m/view/?dc=gorganic";
	MyEntityResolver gEntityResolver = new MyEntityResolver();

	ArrayList	gMainMenu = [ "Main menu", 
	         	              "Feeds", 
	         	              "List" 
	         	            ];
	ArrayList	gFeedsMenu;
	ArrayList	gFeedsURLs;
	ArrayList	gListMenu = [ 
	                          "Next",  		// keep unread and go to next
							  "Star", 		// star and go to next
	                          "Delete",  	// mark read and go to next
	                          "Details", 	// read details
	                          "Repeat",		// repeat item
	                          "Feeds", 		// go to feeds menu
	                          "Main menu", 	// go to main menu
	                          "Help"		// render help
	                        ];
};

GReaderState gState = new GReaderState();

//**********************************************************************************
//    ROUTINES
//**********************************************************************************

String processRequest (URLConnection connection, String method, String dataString)
{
	connection.setRequestMethod(method)
	connection.setRequestProperty("User-Agent", "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.6) Gecko/2009011912 Firefox/3.0.6")
    
    if ( dataString.length() > 0 ) {
		connection.doOutput = true
		Writer writer = new OutputStreamWriter(connection.outputStream)
		writer.write(dataString)
		writer.flush()
		writer.close()		
	}
    connection.connect()
		
    if (connection.responseCode == 200 || connection.responseCode == 201) {
        return connection.content.text									
    }
			
    return "Error " + connection.responseCode;
}

//---------------------------------------------------------------------------------
String createAuthToken ( GReaderState state ) 
{
	def url = new URL("https://www.google.com/accounts/ClientLogin")
    def connection = url.openConnection()		
		
	def queryString = "ltmpl=mobile&service=reader&nui=5&&btmpl=mobile&hl=en&Email=${state.gUsername}&Passwd=${state.gPassword}&PersistentCookie=yes&rmShown=1";	
    def returnMessage = processRequest(connection, "POST", queryString)
		
    if(returnMessage != "Error"){
    	String [] authStrings = returnMessage.split(/\n/);
		authStrings.each { str ->
			if (str.indexOf("Auth=") != -1 ) {
		        state.gAuth = str.split(/Auth=/)[1].trim()
		    }
			if (str.indexOf("LSID=") != -1 ) {
		        state.gLSID = str.split(/LSID=/)[1].trim()
		    }
			if (str.indexOf("SID=") == 0 ) {
		        state.gSID = str.split(/SID=/)[1].trim()
		    }
		}
		state.gLastError = ""
    	return true;
    }

	state.gLastError = "Error opening the login URL";
	return false;
}

//---------------------------------------------------------------------------------
String getURL( GReaderState state, String sURL )  
{
    def url = new URL(new URL("http://www.google.com/reader/"),sURL)
    def connection2 = url.openConnection()		
	connection2.setRequestProperty("Cookie", "SID=${state.gSID}; rememberme=true; domain=.google.com; path=/; expires=1600000000" );
		
    return processRequest(connection2, "GET", "")
}

//---------------------------------------------------------------------------------
String getNextReaderPage ( GReaderState state )
{
    def returnMessage = getURL( state, state.gNextPageURI );
		
    if(returnMessage != "Error"){
    	state.gLastError = ""
    	state.gLastRetrievedPage = returnMessage;
    	return true;
    }

	state.gLastError = "Error opening the first reader page URL";
	return false;

};

//---------------------------------------------------------------------------------
ArrayList getItemsFromPage( GReaderState state )
{
	try {
		long nCurrentTime = System.currentTimeMillis();
		def slurper = new XmlSlurper(false,false)
		slurper.setEntityResolver( state.gEntityResolver );
		slurper.setDTDHandler( new MyDTDHandler() );
		
		def html = slurper.parseText( state.gLastRetrievedPage )
		log( "Parsing items took " + (System.currentTimeMillis()-nCurrentTime) + "ms; text size = " + state.gLastRetrievedPage.length() 	);
	
		state.gPageItemsSet = new ArrayList();
		def table = html.body.table;
		table.tr.each { row ->
			if (row.@class == null || row.@class != "atn" ) {
				GReaderItem item = new GReaderItem();

				def itemCell = row.td[1]
				item.gLinkToItem = itemCell.a[0].@href.text();
				item.gItemTitle = itemCell.a[0].text();
				
				item.gFeedLink = itemCell.a[1].@href.text();
				item.gItemFeed = itemCell.a[1].text();	
				
				state.gPageItemsSet.add( item );
			} else {
				if (row.td[1].a.em.b.text() == "more...") {
					state.gNextPageURI = row.td[1].a.@href.text()
				}
			}
		}
		
		return state.gPageItemsSet;
	} catch ( Exception e ) {
		state.gLastError = e.getMessage();
		return null;
	}
}

//---------------------------------------------------------------------------------
void printItem( GReaderItem item )
{
	println "Link: " + item.gLinkToItem
	println "Title: " + item.gItemTitle
	println "Feed link: " + item.gFeedLink
	println "Feed: " + item.gItemFeed
	println "*********************************"
}

//---------------------------------------------------------------------------------
String presentFeeds( GReaderState state )
{
	while (1) {
		refreshFeeds( state )
			
		if (state.gFeedsMenu.size() == 0) {
			say( "There are no unread items left. Good bye.")
			return "Main menu"
		}
		
		def event = ask("Feeds menu. You can say " + buildMenu(state.gFeedsMenu,1),
				[
				repeat  : 5,
				timeout : 10,
				choices : buildMenu(state.gFeedsMenu,0),
				onBadChoice : { say("Invalid choice. Please try again.") },
				onTimeout   : { say("I did not hear anything. Going with the first feed.") }
				]);
		if ( event.name == "choice" ) {
			state.gNextPageURI = choiceToMenuItem( event.value, state.gFeedsURLs );
			String sFeed = choiceToMenuItem( event.value, state.gFeedsMenu );
			say( "Reading feed " + sFeed )
			String sResult = presentList(state)
			if ( sResult == "Main menu") {
				return "Main menu"
			} else if ( sResult == "Feeds") {
				return "Feeds"
			}
		}		
	}
}
	
//---------------------------------------------------------------------------------
String presentList( GReaderState state )
{
	say( "List menu" );
	
	long nCurrentTime;
	while (1) {
		nCurrentTime = System.currentTimeMillis();
		getNextReaderPage(state);
		if ( state.gLastError != "" ) {
			say("There was an error fetching the R S S items from Google. Good bye!")
			return "Error";
		}
		log( "Fetching items took " + (System.currentTimeMillis()-nCurrentTime) + "ms" );
		
		nCurrentTime = System.currentTimeMillis();
		getItemsFromPage(state);
		if ( state.gLastError != "" ) {
			say("There was an error parsing Google's response - " + state.gLastError + ". Good bye!")
			return "Error";
		}
		log( "Processing items took " + (System.currentTimeMillis()-nCurrentTime) + "ms" );
	
		if ( state.gPageItemsSet.size() == 0 ) {
			return "";
		}

		for(item in state.gPageItemsSet) {
		//state.gPageItemsSet.each {item ->
			int nRepeat = 1;
			int nRepeatMenu = 0;
			int nDetailsRequested = 0;
			def sText;
			while ( nRepeat > 0 || nRepeatMenu > 0 ) {
				
				if ( nRepeat > 0 ) {
					nRepeat = 0;
					say( "<speak><prosody pitch=\"medium\">" + item.gItemFeed + ". " + item.gItemTitle + "</prosody></speak>")
				}
				
				nRepeatMenu = 0;
				event = ask( "",
					[
					repeat		: 1,
					timeout		: 5,
					choices		: buildMenu(state.gListMenu,0),
					onBadChoice : { log("Next item - one") },
					onTimeout   : { log("Next item - two") }
					]
					);
				if ( event.name == "choice") {
					String choice = choiceToMenuItem( event.value, state.gListMenu );
					if ( choice == "Repeat" ) {
						log( "Repeate choice: Repeating current item");
						nRepeat = 1;
					} else if ( choice == "Star" ) {
						log( "Star choice: Starring current item");
						if ( starCurrentItem( state, item ) ) {
							say( "Item starred" );
						} else {
							say( "Error starring item" );
						}
						
					} else if ( choice == "Delete" ) {
						log( "Delete choice: Deleting current item");
						if ( nDetailsRequested == 0 ) {
							// item has not been visited ... visit it to mark as read
							fetchCurrentItemDetails( state, item );
						}
					} else if ( choice == "Next" ) {
						log( "Next choice: Skipping current item");
						// do nothing
					} else if ( choice == "Details" ) {
						log( "Details choice: Rendering details for current item");
						nDetailsRequested = 1;
						nRepeatMenu = 1;
						renderCurrentItemDetails( state, item );
					} else if ( choice == "Feeds" ) {
						log( "Feeds choice: Going to feeds menu");
						return "Feeds";
					} else if ( choice == "Main menu" ) {
						log( "Main menu choice: Going to main menu");
						return "Main menu";
					} else if ( choice == "Help" ) {
						say("List menu. You can say " + buildMenu(state.gListMenu,1));
					}
				}
			}
		}
	}
}

//---------------------------------------------------------------------------------
boolean starCurrentItem(  GReaderState state, GReaderItem item )
{
	if ( item.gStarLink == null ) {
		// need to fetch and parse the item
		String sHTML = fetchCurrentItemDetails( state, item )
		if ( sHTML == "Error" ) {
			return false;
		}
		if ( parseCurrentItemDetails( state, item, sHTML ) == false ) {
			log( "Failed to parse current item details " + state.gLastError );
			return false;
		}
	}

	if ( getURL( state, item.gStarLink ) == "Error" ) {
		return false
	}
	
	return true;
}

//---------------------------------------------------------------------------------
String fetchCurrentItemDetails( GReaderState state, GReaderItem item )
{
	if ( item.gStarLink != null ) {
		// already fetched and parsed
		return "In cache"
	}
	return getURL( state, item.gLinkToItem );
}

//---------------------------------------------------------------------------------
boolean parseCurrentItemDetails( GReaderState state, GReaderItem item, String sHTML)
{
	try {
		def slurper = new XmlSlurper( )
		slurper.setEntityResolver( state.gEntityResolver );
		def html = slurper.parseText( sHTML )
	
		def div4 = html.body.div[4];
		if ( div4.@class != "b" ) {
			throw new Exception( "Couldn't parse item page - 4th div is not of class b (" + div4 + ")" );
		} else {
			item.gDetailsText = div4.text();
			log( "Retrieved current item text: " + item.gDetailsText );
		}

		def div5 = html.body.div[5];
		if ( div5.@class != "n" ) {
			throw new Exception( "Couldn't parse item page - 5th div is not of class n (" + div5 + ")" );
		} else {
			item.gStarLink = div5.table.tr[2].td[1].a[0].@href;
			log( "Retrieved current item star link: " + item.gStarLink );
		}
		
		return true;
	} catch ( Exception e ) {
		state.gLastError = e.getMessage();
		return false;
	}
}

//---------------------------------------------------------------------------------
boolean renderCurrentItemDetails( GReaderState state, GReaderItem item )
{
	if ( item.gStarLink == null ) {
		// need to fetch and parse the item
		String sHTML = fetchCurrentItemDetails( state, item )
		if ( sHTML == "Error" ) {
			log( "Error fetching current item details" );
			return false;
		}
		if ( parseCurrentItemDetails( state, item, sHTML ) == false ) {
			log( "Error parsing current item details" );
			return false;
		}
	}
	
	say ( item.gDetailsText );
	return true;
}

//---------------------------------------------------------------------------------
String choiceToMenuItem( String choiceAsItem, ArrayList menu )
{
	String sIndex = choiceAsItem.substring(4);
	int    nIndex = Integer.parseInt(sIndex.trim())
	String choice = menu[nIndex]
	return choice;
}

//---------------------------------------------------------------------------------
void processMainMenuChoice( GReaderState state, String choiceAsItem )
{
	String choice = choiceToMenuItem( choiceAsItem, state.gMainMenu );
	
	if ( choice == "List" ) {
		presentList( state );
	} else
	if ( choice == "Feeds" ) {
		presentFeeds( state )
	} else
	if ( choice == "Main menu" ) {
		say( "Going back to main menu" )
	} else {
		say( "Undefined choice" );
	}
}

//---------------------------------------------------------------------------------
void refreshFeeds( GReaderState state )
{
	// fetch feeds menu
	String sFeedsXML = getURL( state, "http://www.google.com/reader/m/subscriptions?hl=en" );
	if ( sFeedsXML == "Error") {
		throw new Exception("Error fetching feeds list")
	}
	
	state.gFeedsURLs = new ArrayList()
	state.gFeedsMenu = new ArrayList()
	
	def slurper = new XmlSlurper( )
	slurper.setEntityResolver( state.gEntityResolver );
	def html = slurper.parseText( sFeedsXML )
	def ul = html.body.div[1].ul;
	
	ul.li.each { feed->
		
		if (feed.span != null) {
			String sText = feed.a.text()
			def alphaPattern = Pattern.compile("([0-9A-Za-z ]*).*");			
			def alphaMatcher = alphaPattern.matcher(sText);
			if ( alphaMatcher.find() ) {
				sText = alphaMatcher.group(1)
			}
			
			// only add feeds with items in them
			state.gFeedsURLs.add( feed.a.@href );
			state.gFeedsMenu.add( sText );
		}
	}				
}

//---------------------------------------------------------------------------------
String buildMenu( ArrayList menuItems, int nOnlyItems )
{
	String sResult = new String();
	int    nIndex = 0;
	menuItems.each { item ->
		if (item.length() > 0) {
			if ( sResult.length() > 0 ) {
				sResult = sResult + ", ";
			}
			if ( nOnlyItems ) {
				sResult = sResult + item;
				if (nIndex<=9) {
					sResult = sResult + " or press " + nIndex;
				}
			} else {
				sResult = sResult + "item" + nIndex + " (" + item;
				if (nIndex<=9) {
					sResult = sResult + "," + nIndex;
				
				}
				sResult = sResult + ")";
			}
			nIndex++;
		}
	}
	return sResult;
}

//**********************************************************************************
//    STUBS - useful for debugging
//**********************************************************************************

/*
void answer()
{
}

void say(String s, Map m)
{
	println "Say: ---" + s;	
}

void say(String s)
{
	println "Say: ---" + s;	
}

static Map ask(String s, Map m)
{
	BufferedReader reader = System.in.newReader();
	println "Ask: ---" + s;	
	String sIn = reader.readLine()
	def result = [name:'choice', value:"item ${sIn}"];
	if ( m.onChoice ) {
		m.onChoice( result );
	}
	
	return result
}

void ask(String s)
{
	println "Ask: ---" + s;	
}

void log(String s)
{
	println "Log: ---" + s;
}
*/

//**********************************************************************************
//    MAIN
//**********************************************************************************

answer();
createAuthToken(gState);
if ( gState.gLastError != "" ) {
	say("There was an error authenticating with Google. Good bye!")
	return;
}


say("Hello and welcome to Google Reader phone application.");

while (1) {
	ask("You can say " + buildMenu(gState.gMainMenu, 1),
			[
			repeat      : 100,
			timeout		: 5,		
			choices     : buildMenu(gState.gMainMenu, 0),
			onTimeout	: { event-> processMainMenuChoice( gState, "List" ) },
			onBadChoice : { say("Invalid input. Please try again" ) },
			onChoice    : { event-> processMainMenuChoice( gState, event.value ) }
			]
			);
}