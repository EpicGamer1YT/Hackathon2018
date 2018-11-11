from gpiozero import MotionSensor
import time as time
from firebase import firebase
from twilio.rest import Client

firebase = firebase.FirebaseApplication('https://hackathon2018sugar.firebaseio.com/')
pir = MotionSensor(4)
account_sid = 'AC9b7a4d31df1973ab22b500941997a8de'
auth_token = '1d2dec566529c3949c3832456b151429'
client = Client(account_sid, auth_token)

pir.wait_for_motion()
message = client.messages \
                .create(
                     body="There has been motion detected in your home. Please take actions accordingly.",
                     from_='+19739750212',
                     to='+19737131511'
                 )
result = firebase.put('/motion', '/detection' ,'Intruder')
print("Motion Detected!")


'''def motion():
    while True:
        if pir.wait_for_motion == True:
            pir.wait_for_motion()
            print("You moved")
            time.sleep(1)
        else:
            print("Good")
            time.sleep(1)'''


