# --------------------------------------------
# changing behavior based on number called
# See http://www.tropo.com for more info
# --------------------------------------------

# HAS NOT BEEN VERIFIED TO WORK YET

answer()

if (currentCall.calledID == '4075551111'):
    say("Hello Andrew")
if (currentCall.calledID == '4075552222'):
    say("Hello Brian")

hangup()
