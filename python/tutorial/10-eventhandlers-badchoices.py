# -------------------------------------
# handling bad choices and no response (timeout) with event handlers
# -------------------------------------

# =============================
# THIS APP NEEDS TO BE VERIFIED
# Ported from JavaScript, but not verified to work
# =============================

answer()

result = ask("Hi. For sales, say sales or press 1. For support, say support or press 2", 
{'choices':"sales(1,sales), support(2,support)", 'repeat':3, 
'onBadChoice': lambda : say("I'm sorry, I didn't understand what you said."),
'onTimeout': lambda : say("Hm. I didn't hear anything.")})

if (result.name == 'choice'):
    if (result.value == "sales"): 
        say("Ok, let me transfer you to sales")
	transfer("14075551111")
    if (result.value == "support"): 
        say("Ok, let me transfer you to support")
	transfer("14075552222")

