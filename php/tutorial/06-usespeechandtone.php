<?php
// -----------
// using both speech and touch-tone input
// -----------

answer();

$result = ask( "For sales, just say sales or press 1. For support, say support or press 2.", 
			array( "choices" => "sales( 1, sales), support( 2, support)", "repeat" => 3 ) );

if ($result->name=="choice")
{
	if ($result->value=="sales") say( "sales is not available right now."       ) ;
	if ($result->value=="support") say( "support is currently on the other line." ) ; 
}

hangup();

?>