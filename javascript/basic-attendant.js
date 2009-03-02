// ===========
// Tropo basic auto attendant sample application
// v1 jrt
// ===========

// -----------
// kludge to quit

function allDone()
{
   throw( "exiting" );
}

// -----------
// turn the contacts into a comma seperated list of names

function listNames( theContacts )
{
  var s = '';
  for( var contact in theContacts )
  {
    if (s != '') { s = s + ", " };
    s = s + contact;
  }
  return s;
}

// -----------
// turn the contacts into a comma seperated list of options for each contact (simple grammar)

function listOptions( theContacts )
{
  var s ='';
  for( var contact in theContacts )
  {
    if (s != '') { s = s + ", " };
    s = s + contact + " (" + theContacts[ contact ].nameChoices + ")";
  }
  return s;
}

// -----------
// start
// -----------

// define the list of contacts

var contacts = { 	"jonathan": { nameChoices: "Jonathan, Jonathan Taylor", number: "14074434233" },
					"michael" : { nameChoices: "Michael, Michael Smith",    number: "14074181800" },
					"stephen" : { nameChoices: "Stephen, Stephen Neish",    number: "14076463131" } };

// answer the phone and play the initial greeting

answer( 30 );

prompt( "hello, and thank you for calling." );

// prompt the user for the name of the person they desire

event=prompt( "Who would you like to call?  Just say " + listNames( contacts ),
		{
		  repeat:3,
		  timeout:7,
		  choices:listOptions( contacts ),
		  onEvent: function( event )
          {
		    event.onTimeout( function() { say( "I'm sorry, I didn't hear anything." ) } );
		    event.onBadChoice( function() { say( "I'm sorry, I didn't understand what you said." ) } );
			//event.onHangup( allDone() );
		  }
		} ) ;

// if they made a choice, transfer to that person

if (event.name=='choice')
{
  say( "ok, you said " + event.value +".  Please hold while I transfer you." );

var ne = transfer( "sip:9"+contacts[ event.value ].number+"@10.6.63.201",
     {
     answerOnMedia: false,
     callerID:      "tel:+14076179024",
     timeout:       60.3456,
     method:        "bridged", // fixed to bridged currently
     playrepeat:    3,
     playvalue:     "Ring... Ring... Ring...",
     choices:       "1,2,3,4,5,6,7,8,9,0,*,#",
     onSuccess:     function(event){ log("*********transfered to " + event.value.calleeId)},
     onError:       function(event){ log("*********transfer error")},
     onTimeout:     function(event){ log("*********transfer timeout")},
     onCallFailure: function(event){ log("*********transfer failed")},
     onChoice:      function(event){ log("*********transfer canceled")}
     } )

  log( "transfer event.name  = " + ne.name );
  log( "transfer event.value = " + ne.value );
  say( "The other party disconnected.  Goodbye" );

}

hangup();
