// --------------------------------------------
// using speech input instead of touch-tone
// See http://www.tropo.com for more info
// --------------------------------------------


answer();

result=ask( "For sales, just say sales.  For support, say support.", 
			{choices:"sales, support", repeat:3} );

if (result.name=='choice')
{
	if (result.value=="sales")   { say( "sales is not available right now."       ) }
	if (result.value=="support") { say( "support is currently on the other line." ) }
}

hangup();
