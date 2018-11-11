
#!/usr/bin/python
import sys
import Adafruit_DHT
from firebase import firebase

firebase = firebase.FirebaseApplication('https://hackathon2018sugar.firebaseio.com/')
humid = firebase.get("/count/humidity", None)
humidCount = 1
if humid is not None:
    humidCount = int(humid)
temp = firebase.get("/count/temperature", None)
tempCount = 1
if temp is not None:
    tempCount = int(temp)
while True:

    humidity, temperature = Adafruit_DHT.read_retry(11, 17)
    temperature = (temperature * 9/5) + 32
    prevTemp = firebase.get("/temperature/current_inside", None)
    if prevTemp is not None:
	firebase.put("/temperature/old", tempCount, prevTemp)
	firebase.put("/count", "/temperature", str(int(tempCount) + 1))
	tempCount += 1
    prevHumid = firebase.get("/humidity/current_inside", None)
    if prevHumid is not None:
	firebase.put("/humidity/old", humidCount, prevHumid)
	firebase.put("/count", "/humidity", str(int(humidCount) + 1))
	humidCount += 1
    firebase.put("/humidity", "/current_inside", humidity)
    firebase.put("/temperature", "/current_inside", temperature)
    print 'Temp: {0:0.1f} F  Humidity: {1:0.1f} %'.format(temperature, humidity)
