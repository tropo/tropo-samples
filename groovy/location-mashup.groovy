// --------------------------------------------
// location mashup example by Dustin H.
// See http://www.tropo.com for more info
// --------------------------------------------

// NOTE: To use this sample, you need to obtain a valid license key from
// http://www.fraudlabs.com/areacodeworld.aspx
// and replace "LICENSEKEY" in the URL below  with the key provided to you.

answer()

def strSipURI = currentCall.callerID;
def strNPA = strSipURI.substring(0,3);
def strNXX = strSipURI.substring(3,6);

  say("<speak> Hello, You are calling from <say-as interpret-as='vxml:digits'>$strSipURI</say-as>. </speak>")

log("NPA = ${strNPA} NXX = ${strNXX}")

String xml = "http://ws.fraudlabs.com/areacodeworldwebservice.asmx/AreaCodeWorld?NPA=$strNPA&NXX=$strNXX&LICENSE=LICENSEKEY".toURL().text 

XmlParser parser = new XmlParser()
def strXML = parser.parseText (xml)

  say(" which is located in ${strXML.CITY.text()} at latitude ${strXML.LATITUDE.text()} and longitude ${strXML.LONGITUDE.text()}. You are in ${strXML.COUNTY.text()} county, which has a population of ${strXML.COUNTY_POPULATION.text()}. Your time zone is G M T ${strXML.TIMEZONE.text()}".toLowerCase());

hangup()

