answer() 

def asDigits(instr) {
  def s  = '';
 
  for (def i=0; i < instr.length(); i++) {
    s = s + instr.charAt(i) + ' ';
  }

  return s;
}

def getZipCode() {
        event = ask( "",[ choices:"[5 DIGITS]", repeat:3, timeout:60,
        onTimeout: { say( "I'm sorry, I didn't hear anything.") },
        onBadChoice: { say( "I'm sorry, I did not understand your response.") }]);
        if (event.name=="choice") {zipcode = event.value}
        return zipcode
}

def trafficurl = "http://local.yahooapis.com/MapsService/V1"

def appid = "KgtDvNrV34Eavq_dUF81vBlVLKAOq7o1tj7Tzvu_kYbKsCtBW190VmrvVHK_0w--"

say( "Welcome to the Tropo Traffic System, brought to you by Yahoo Local!")

say("Please enter the 5 digit zip code for which you would like to hear traffic alerts")

def zipcode = getZipCode()
// def zipcode = "32801" // Downtown Orlando
// def zipcode = "20001" // Washington, DC - always plenty of results

say ("Thank you!") 

say( "The zip code you have entered is " + asDigits(zipcode) )

def trafficxml = new XmlSlurper().parseText( "${trafficurl}/trafficData?appid=${appid}&zip=${zipcode}".toURL().text)

def incidentCount = trafficxml.Result.size()

def verb=" are "; def results=" results "
if (incidentCount == 0) {incidentCount="no"}
if (incidentCount == 1) {verb=" is ";results= " result "}

say("There" + verb + incidentCount + results + "for your zip code!")

def count = 1

trafficxml.Result.each { result -> say("Item " + count++ + ": " + result.Title.text() + ", " + result.Description.text())}

say("That completes your traffic report for zipcode " + asDigits(zipcode) + ". Goodbye!") 

hangup()