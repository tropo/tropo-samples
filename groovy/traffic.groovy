// Gives you the traffic conditions based on a zip code
// Mashup using Yahoo!Local by Gordon C.

/* Debug Stubs for Tropo primitives
def say(instr) {println instr}
def answer() {println "answering phone"}
def ask(instr,args) {println instr; println args}
def hangup() {println "hanging up"}
*/

answer() 

def asDigits(instr) {
  def s  = '';
 
  for (def i=0; i < instr.length(); i++) {
    s = s + instr.charAt(i) + ' ';
  }

  return s;
}

def getZipCode() {
    def zipcode = ''
    def bDone  = false
    while (!bDone) {
        event = ask( "",[choices:"0,1,2,3,4,5,6,7,8,9",timeout:10])
        if (event.name=="choice") {
            zipcode += event.value
            } else {
            bDone = true
        }    
        if (zipcode.length() == 5) {bDone = true}
    }
    return zipcode
}

def trafficurl = "http://local.yahooapis.com/MapsService/V1"

def appid = "KgtDvNrV34Eavq_dUF81vBlVLKAOq7o1tj7Tzvu_kYbKsCtBW190VmrvVHK_0w--"

say( "Welcome to the Tropo Traffic System, brought to you by Yahoo Local!")

say(",,,Please enter the 5 digit zip code for which you would like to hear traffic alerts")

def zipcode = getZipCode()
// def zipcode = "32801" // Downtown Orlando
// def zipcode = "20001" // Washington, DC - always plenty of results

say ("Thank you!") 

say( "The zip code you have entered is " + asDigits(zipcode) )

def trafficxml = new XmlSlurper().parseText( "${trafficurl}/trafficData?appid=${appid}&zip=${zipcode}".toURL().text)

def incidentCount = trafficxml.Result.size()

if (incidentCount == 0) {incidentCount="no"}

say(", There are " + incidentCount + " results for your zip code!")

def count = 1

trafficxml.Result.each { result -> say(",,Item " + count++ + "!, " + result.Title.text() + ", " + result.Description.text())}

say("That completes your traffic report for zipcode " + asDigits(zipcode) + ". Goodbye!") 

hangup()
