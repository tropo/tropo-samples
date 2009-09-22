# --------------------------------------------
# connecting the call to another number
# See http://www.tropo.com for more info
# --------------------------------------------

answer()

result = ask("Hi. For sales, say sales or press 1. For support, say support or press 2", {'choices':"sales(1,sales), support(2,support)", 'repeat':3})

if (result.name == 'choice'):
    if (result.value == "sales"): 
        say("Ok, let me transfer you to sales")
	transfer("tel:+14129272358")
    if (result.value == "support"): 
        say("Ok, let me transfer you to support")
	transfer("tel:+14129272341")

hangup()
