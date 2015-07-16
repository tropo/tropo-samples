
/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */


def listNames(theContacts) {
    def results = ''
    
    theContacts.each {
        if (results != '') { 
            results = results + ", "
        }
        results += it.key
    }
    
    return results
}

def listOptions(theContacts) {
    def results = ''
  
    theContacts.each {
        if (results != '') { 
            results = results + ", "
        }
        results += it.key + " (" + it.value.nameChoices + ")"
    }
    
    return results;
}

def contacts = [
    "jonathan": [ nameChoices: "Jason, Jason Goecke", number: "14075551212" ],
    "michael" : [ nameChoices: "Adam, Adam Kalsey", number: "14075551313" ],
    "stephen" : [ nameChoices: "Jose, Jose de Castro", number: "14075551414" ] ]

say( "Hello, and thank you for calling." )

def text = "Who would you like to call? Just say " + listNames( contacts )
def event = ask(text, [
    attempts:3, 
    timeout:7, 
    choices:listOptions( contacts ), 
    onEvent: { event->
        event.onTimeout( { say( "I'm sorry, I didn't hear anything." ) } )
        event.onBadChoice( { say( "I'm sorry, I didn't understand what you said." ) } )
    }
    ]
)

// If a choice was made, transfer to that person
if (event.name == "choice") {
    say( "Ok, you said " + event.value + ". Please hold while I transfer you." );
   
    def ne = transfer( "tel:+${contacts[ event.value ].number}, [
        answerOnMedia: false,
        callerId:      "+14076179024",
        timeout:       60.3456,
        playrepeat:    3,
        playvalue:     "Ring... Ring... Ring...",
        onSuccess:     { ne-> log("*********transferred to $event.value.calledID") },  
        onError:       { ne-> log("*********transfer error") },  
        onTimeout:     { ne-> log("*********transfer timeout") },  
        onCallFailure: { ne-> log("*********transfer failed") }
    ] )

    log "transfer event.name  = $ne.name"
    log "transfer event.value = $ne.value"
    
    say "Goodbye" 
}
