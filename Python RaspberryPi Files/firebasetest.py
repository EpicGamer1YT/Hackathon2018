from firebase import firebase

import RPi.GPIO as GPIO


GPIO.setmode(GPIO.BOARD)

GPIO.setwarnings(False)

GPIO.setup(12, GPIO.OUT)

p = GPIO.PWM(12,50)

p.start(7.5)

old_Result = 2.5

result = 2.5
firebase = firebase.FirebaseApplication('https://hackathon2018sugar.firebaseio.com/')
while True:
    
    old_Result = result
    result = firebase.get('/roundPos',None)

    print(result)
    if result != old_Result:
        p.ChangeDutyCycle(float(result))
    
    
