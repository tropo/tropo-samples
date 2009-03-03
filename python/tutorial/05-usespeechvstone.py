# --------------------------------------------
# Using speech input instead of touch-tone
# See http://www.tropo.com for more info
# --------------------------------------------

answer()

result = ask("Hi. For sales, say sales. For support, say support",
{'choices':"sales, support", 'repeat':3})

if (result.name == 'choice'):
    if (result.value == "sales"): 
        say("Sales is not available right now")
    if (result.value == "support"): 
        say("Support is currently on the other line.")

hangup()
