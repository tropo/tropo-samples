# --------------------------------------------
# Using both speech and touch-tone input
# See http://www.tropo.com for more info
# --------------------------------------------

answer()

result = ask("Hi. For sales, say sales or press 1. For support, say support or press 2", {'choices':"sales(1,sales), support(2,support)", 'repeat':3})

if (result.name == 'choice'):
    if (result.value == "sales"): 
        say("Sales is not available right now")
    if (result.value == "support"): 
        say("Support is currently on the other line.")

hangup()
