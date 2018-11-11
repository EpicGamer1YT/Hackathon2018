from firebase import firebase

import RPi.GPIO as GPIO


GPIO.setmode(GPIO.BOARD)

GPIO.setwarnings(False)

GPIO.setup(35, GPIO.OUT)

p = GPIO.PWM(35,50)

p.start(7.5)

old_Result = 12.5

result = 12.5
firebase = firebase.FirebaseApplication('https://hackathon2018sugar.firebaseio.com/')
while True:
    
    old_Result = result
    result = firebase.get('/heightPos',None)

    print(result)
    if result != old_Result:
        p.ChangeDutyCycle(12.5 - float(result))
    
    
