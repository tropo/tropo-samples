// -------------
// Tutorial 16 - collecting digits
// -------------

answer();

result=prompt( "Hello.  Please enter any number", [ choices:"[DIGITS]" ] );

if (result.name=='choice') { say( "Great, you said " + result.value ) };
	
hangup();