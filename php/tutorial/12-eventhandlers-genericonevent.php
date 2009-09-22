<?php
// -----------
// using the generic onEvent handler instead
// -----------

answer();

ask( "Hi. For sales, just say sales or press 1. For support, say support or press 2.", 
		array(
  				"choices" => "sales( 1, sales), support( 2, support)", 
  				"repeat"  => 3,
			  	"onEvent" => create_function( '$event', 
			 
				'if ($event->name == "badChoice") say( "I am sorry, I did not understand what you said.");
				if ($event->name == "timeout") say( "I am sorry. I did not hear anything.");
				if ($event->name == "choice")
				{
					if ($event->value == "sales")
					{
						say( "Ok, let me transfer you to sales." );
						transfer( "tel:+14129272358" );
					}
					if ($event->value == "support")
					{
						say( "Sure, let me get support.  Please hold." );
						transfer( "tel:+14129272341" );
					}
				}'
				

				)
		)
);

?>
