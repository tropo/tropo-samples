// --------------------------------------------
// using the generic onEvent handler instead
// See http://www.tropo.com for more info
// --------------------------------------------

answer();

ask( "Hi. For sales, just say sales or press 1. For support, say support or press 2.", 
			[ 
			  choices:"sales( 1, sales), support( 2, support)", repeat:3,
			  onEvent: {event->
				if (event.name=='badChoice') { say( "I'm sorry, I didn't udnerstand what you said.") }
				if (event.name=='timeout')   { say( "I'm sorry. I didn't hear anything.") }
				if (event.name=='choice')
				{
					if (event.value=='sales')
					{
						say( "Ok, let me transfer you to sales." );
						transfer( "tel:+14129272358");
					}
					if (event.value=='support')
					{
						say( "Sure, let me get support.  Please hold." );
						transfer( "tel:+14129272341");
					}
				}
				transfer( "tel:+14129272358");	
			  }
			] );
			


