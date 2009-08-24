import java.math.*

answer()

precision = new MathContext(3) 

def calcBMI(heightInM, weightInKG)
    {
    def BMIndex = (weightInKG.divide(heightInM**2, precision))
    return BMIndex
    } 
    
def calcIdealWeight(heightInM,idealBMIndex)
    {
    def idealWeightKG = (idealBMIndex*(heightInM**2))
    return idealWeightKG
    }
    
def getWeightInLB() {
    def weightInLB = ''
    event = ask("",[choices:"[2-3 DIGITS]"])
        if (event.name=="choice") {
                 weightInLB = event.value
            } 
    say "Thank you! You weigh " + weightInLB + " pounds."
    return weightInLB
}
  
def getHeightInInches() {
    def HeightInInches = ''
    response = ask( "",[choices:"[2 DIGITS]"])
        if (response.name=="choice") {
                HeightInInches = response.value
            } 
    say "Thank you! You are " + HeightInInches + " inches tall."
    return HeightInInches
}  

say ("Welcome to the Tropo Body Mass Index calculator!  To get started, please enter your weight in pounds...")

def weightInLB = getWeightInLB()
//def weightInLB = "300"; say ("Weight in pounds: " + weightInLB)

say ("Now enter your height in inches:")

def heightInInches = getHeightInInches()
// def heightInInches = 76; say ("Height in inches: " + heightInInches)

def heightInM = ((heightInInches as int) * 0.0254)
// say ("Height in meters:" + heightInM)

def weightInKG = ((weightInLB as int) * 0.4535924)
// say ("Weight in KG: " + weightInKG.round(precision))

def BMI = calcBMI(heightInM, weightInKG)
say  "Your Body Mass Index is " + BMI + "."

def BMIDescription = ""
if(BMI < 18.5) { BMIDescription = "Oh dear, your weight is too low for optimum health. " } 
if(BMI >= 18.5 && BMI <= 24.9) { BMIDescription = "Congratulations, your weight is in the healthy range! "}
if(BMI >= 25 && BMI <= 29.9) { BMIDescription = "Hmmm, your weight is a bit too high. "}
if(BMI > 30 && BMI <= 40) { BMIDescription = "Oh dear, your weight is in the obese range. " }
if(BMI > 40) { BMIDescription = "Woah Nelly! Your weight is in the morbidly obese range. "}
say BMIDescription

//Ideal BMI Range
def minIdealBMIndex = 18.5; def maxIdealBMIndex = 24.9
def minIdealWeightKG = calcIdealWeight(heightInM,minIdealBMIndex)
def minIdealWeightLB = minIdealWeightKG/0.4535924 as int 
def maxIdealWeightKG = calcIdealWeight(heightInM,maxIdealBMIndex)
def maxIdealWeightLB = maxIdealWeightKG/0.4535924 as int

say "According to the US National Institutes of Health, your ideal weight is between " + minIdealWeightLB + " and " + maxIdealWeightLB + " pounds.  Thank you for using the Tropo BMI calculator.  Goodbye!"

hangup()