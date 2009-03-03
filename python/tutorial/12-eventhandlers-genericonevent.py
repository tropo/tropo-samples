# --------------------------------------------
# using the generic onEvent handler instead
# See http://www.tropo.com for more info
# --------------------------------------------

answer()

ask("Hi. For sales, say sales or press 1. For support, say support or press 2", 
{'choices':"sales(1,sales), support(2,support)", 'repeat':3, 
'onEvent':lambda event :
      event.onChoice( "sales", lambda : say("Ok, let me transfer you to sales" ) and transfer("14129272358")) and
      event.onChoice( "support", lambda : say("Ok, let me transfer you to support") and transfer("14129272341") ) and
      event.onBadChoice( lambda : say("I'm sorry, I didn't understand what you said. " ) ) and
      event.onError( lambda : say("You've got an error! " ) ) and
      event.onTimeout( lambda : say("I'm sorry. I didn't hear anything" ) )
})
