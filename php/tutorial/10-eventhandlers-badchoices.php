<?php
// -----------
// handling bad choices and no response (timeout) with event handlers
// -----------

answer();

$result = ask( "For sales, just say sales or press 1. For support, say support or press 2.", 
				array( "choices"     => "sales( 1, sales), support( 2, support)", 
				       "repeat"      => 3,
			  		   "onBadChoice" => create_function( '$event', 'say("I am sorry, I did not understand what you said.");' ),
			  		   "onTimeout"   => create_function( '$event', 'say("Hm.  I didn\'t hear anything.");' )
				)
			);

if ($result->name=='choice')
{
	if ($result->value=="sales") 
	{ 
		say( "Ok, let me transfer you to sales."       );
		transfer( "14075551111");
	}
	if ($result->value=="support") 
	{ 
		say( "Sure, let me get support.  Please hold." );
		transfer( "14085552222");
	}
}

?>