// --------------------------------------------
// using the generic onEvent handler instead
// See http://www.tropo.com for more info
// --------------------------------------------

answer();

ask( "Hi. For sales, just say sales or press 1. For support, say support or press 2.", 
			{ 
			  choices:"sales( 1, sales), support( 2, support)", repeat:3,
			  onEvent: function( event ) 
			  {
				switch( event.name )
				{
					case 'badChoice': say( "I'm sorry, I didn't understand what you said."); break
					case 'timeout'  : say( "I'm sorry. I didn't hear anything."); break
					case 'choice'   :
						switch ( event.value + "")
						{
							case 'sales':
								say( "Ok, let me transfer you to sales." );
								transfer( "tel:+14129272358");
							break
							case 'support':
								say( "Sure, let me get support.  Please hold." );
								transfer( "tel:+14129272341");
							break					
						}		
				}	
			  }
			} );
			


