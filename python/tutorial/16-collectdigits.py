# 16 - Collect digits python

answer();

result = ask( "Hello.  Please enter any number", { 'choices' : "[DIGITS]" });

if result.name == 'choice' :
    say( "Great, you said " + result.value )

hangup()
