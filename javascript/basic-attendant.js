/*
 * Copyright (c) 2009 - 2015 Tropo, now part of Cisco
 * Released under the MIT license. See the file LICENSE
 * for the complete license
 */

// ===========
// Tropo basic auto attendant sample application
// ===========

// -----------
// kludge to quit

function allDone()
{
   throw( "exiting" );
}

// -----------
// turn the contacts into a comma separated list of names

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
// turn the contacts into a comma separated list of options for each contact (simple grammar)

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

var contacts = { 	"jason": { nameChoices: "Jason, Jason Goecke", number: "14075551212" },
					"adam" : { nameChoices: "Adam, Adam Kalsey",    number: "14075551313" },
					"jose" : { nameChoices: "Jose, Jose de Castro",    number: "14075551414" } };

// answer the phone and play the initial greeting

say("hello, and thank you for calling.");

// ask the user for the name of the person they're looking to reach

event=ask( "Who would you like to call?  Just say " + listNames( contacts ),
		{
		  attempts:3,
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

var ne = transfer( "tel:+"+contacts[ event.value ].number,
     {
     answerOnMedia: false,
     callerID:      "+14076179024",
     timeout:       60.3456,
     playrepeat:    3,
     playvalue:     "Ring... Ring... Ring...",
     onSuccess:     function(event){ log("*********transferred to " + event.value.calledID)},
     onError:       function(event){ log("*********transfer error")},
     onTimeout:     function(event){ log("*********transfer timeout")},
     onCallFailure: function(event){ log("*********transfer failed")}
     } )

  log( "transfer event.name  = " + ne.name );
  log( "transfer event.value = " + ne.value );
  say( "Goodbye" );

}
