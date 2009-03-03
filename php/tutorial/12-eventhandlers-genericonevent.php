<?php
// -----------
// using the generic onEvent handler instead
// -----------

answer();

ask( "Hi. For sales, just say sales or press 1. For support, say support or press 2.", 
		array(
  				"choices" => "sales( 1, sales), support( 2, support)", 
  				"repeat"  => 3,
			  	"onEvent" => create_function( '$event', <<<EOT
			 
				if ($event->name == 'badChoice') say( "I am sorry, I didn't understand what you said.");
				if ($event->name == 'timeout') say( "I am sorry. I didn't hear anything.");
				if ($event->name == 'choice')
				{
					if ($event->value == 'sales')
					{
						say( "Ok, let me transfer you to sales." );
						transfer( "14075551111");
					}
					if ($event->value == 'support')
					{
						say( "Sure, let me get support.  Please hold." );
						transfer( "14085552222");
					}
				}
				
EOT
				)
		)
);

?>
