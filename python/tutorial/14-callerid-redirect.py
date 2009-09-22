# --------------------------------------------
# redirect a call based on caller ID
# See http://www.tropo.com for more info
# --------------------------------------------

if (currentCall.callerID == '4075551111'):
    answer()
    say("Hello, world!")
    hangup()
else:
    redirect("tel:+14075552222")

