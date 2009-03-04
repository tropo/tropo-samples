// --------------------------------------------
// Weather example - retrieves a NOAA weather report based on (US) ZIP code
// See http://www.tropo.com for more info
// --------------------------------------------

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

def getNoaaReport(zipcode) {
   def sectionMarker = ['<a name="contents"></a>', '<span class="warn">hazardous weather outlook</span></a></div>', '<span class="warn">red flag warning</span></a></div>', '<span class="warn">fire weather watch</span></a></div>']

   // Get report from NOAA's website
   def report=new URL("http://forecast.weather.gov/zipcity.php?inputstring=${zipcode}").getText().toLowerCase().replaceAll("<br>", "")
   def sectionFrom=report.indexOf(sectionMarker[0])

   report = report[ sectionFrom ..< report.indexOf('</td>', sectionFrom)].minus(sectionMarker[0]).replaceAll("<b>", "").replaceAll("</b>", "").replaceAll("mph", "miles per hour")

    for(i in 1 ..< sectionMarker.size()){
        sectionFrom = report.indexOf(sectionMarker[i])
        if (sectionFrom != -1){
            report = report[sectionFrom ..< report.length()].minus(sectionMarker[i])
        }
    }

   return report.replace(".", ".\n")
}

answer(30)

// Welcome
say( "Hello, and thank you for using our service." )
say( "Please enter the 5 digit zip code for which you would like to hear the weather report." )

def zipcode = getZipCode()

// Get report from NOAA's website
def report=getNoaaReport(zipcode)
say("<speak>Here is the weather report for zip code <say-as interpret-as='vxml:digits'> ${zipcode}</say-as> ${report}</speak>")

hangup()
