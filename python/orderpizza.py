#Order a pizza with different toppings


def sayToppings(top):
    for topping in top:
        say(topping)
    return


#def main():
    
    
answer()
wait(500)
say("Welcome at Alfredos's Pizza Network.")
wait(500)
say("Please choose your size first, then the toppings.")

result = ask("We offer small, medium and family size pizzas. Which size would you like?",
{'choices':"small,1,medium,2,family,3,large", 'repeat':3})

if (result.name == 'choice'):
    if (result.value == "small")or (result.value == "1"): 
        say("OK, a small pizza.")
    elif (result.value == "medium")or (result.value == "2"): 
        say("I'll fix a Medium pizza for you")
    elif (result.value == "family") or (result.value == "large")or (result.value == "3"):
        say("A family sized pizza, no problem.")
#    else:
#        say("Please choose between small, medium and family size")

say("Which toppings would you like?")
say("Please add one topping at a time. You will return to the topping selection menu unless you say done")



say("Let's start with the vegetarian choices")

veggietoppings = []
exit = False
cnt = 0
while(exit == False):
    cnt += 1
    result = ask("Choose between peppers, onions, jalapenos, mushrooms, corn. To finish say done or press 9",
    {'choices':"peppers, 1, onions, 2, jalapenos, 3, mushrooms, 4, corn, 4, done, 9", 'repeat':1})
    
    if (result.name == 'choice'):
        if (result.value == "peppers")or (result.value == "1"): 
            veggietoppings.append("peppers")
            say("Adding peppers")
        elif (result.value == "onions")or (result.value == "2"): 
            veggietoppings.append("onions")
            say("Adding onions")
        elif (result.value == "jalapenos")or (result.value == "3"): 
            veggietoppings.append("jalapenos")
            say("Adding jalapenos")
        elif (result.value == "mushrooms")or (result.value == "4"): 
            veggietoppings.append("mushrooms")
            say("Adding mushrooms")
        elif (result.value == "corn")or (result.value == "5"): 
            veggietoppings.append("corn")
            say("Adding corn")
        elif (result.value == "done")or (result.value == "9"): 
            say("So we have the following toppings so far:")
            sayToppings(veggietoppings)
            exit = True
    if (cnt == 3):
	        exit = True
    if exit:
        result2 = ask("Do you want to add more toppings?", {'choices':"yes(1,yes), no(2,no)", 'repeat':2})
        if (result2.name == 'choice'):
            if (result2.value == "yes") or (result2.value == "1"): 
                exit = False
            elif (result2.value == "onions") or (result2.value == "2"): 
                exit = True
say("And now the other ones")        
meattoppings = []
exit = False
cnt = 0
while(exit == False):
    cnt += 1
    result = ask("Choose between pepperoni, ham, bacon. To finish say done or press 9",
    {'choices':"pepperoni, 1, ham, 2, bacon, 3, done, 9", 'repeat':3})
    
    if (result.name == 'choice'):
        if (result.value == "pepperoni")or (result.value == "1"): 
            meattoppings.append("pepperoni")
            say("Adding pepperoni")
        elif (result.value == "ham")or (result.value == "2"): 
            meattoppings.append("ham")
            say("Adding ham")
        elif (result.value == "bacon")or (result.value == "3"): 
            meattoppings.append("bacon")
            say("Adding bacon")
#        elif (result.value == "mushrooms")or (result.value == "4"): 
#            veggietoppings.append("mushrooms")
#        elif (result.value == "corn")or (result.value == "5"): 
#            veggietoppings.append("corn")
        elif (result.value == "done")or (result.value == "9"): 
            say("So we have the following toppings so far:")
            sayToppings(meattoppings)
            exit = True
    if (cnt == 3):
            exit = True
    if exit:
        result2 = ask("Do you want to add more toppings?", {'choices':"yes(1,yes), no(2,no)", 'repeat':2})
        if (result2.name == 'choice'):
            if (result2.value == "yes") or (result2.value == "1"): 
                exit = False
            elif (result2.value == "onions") or (result2.value == "2"): 
                exit = True
                    
say("I have the following toppings for your pizza")
sayToppings(veggietoppings)
say("and")
sayToppings(meattoppings)

say("Please provide your address now")

#add delivery address recording here

#tell the caller when to expect the pizza
deliverytime = str((len(veggietoppings) + len(meattoppings))*2) 
say("We will deliver your pizza in " + deliverytime + " Minutes")
    
say("Thanks for ordering at Alfredos's Pizza Network.")

wait(500)
               

hangup()
