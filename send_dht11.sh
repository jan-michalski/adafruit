#!/bin/sh
 
# Domoticz server
SERVER="192.168.0.10:8080"
# DHT IDX
DHTIDX="1"
 
# DHTPIN
DHTPIN="4"
 
sleep 5
 
python3 /home/pi/adafruit/dht11.py 11 $DHTPIN > /var/tmp/temp.txt
#TEMP=$(cat /var/tmp/temp.txt | grep "Temp" | awk '{ print $3 }')
#TEMP=$(cat /var/tmp/temp.txt | grep "Temp")
 
TEMP=$(awk ' /Temp/ {print substr ($0,7,4)}' /var/tmp/temp.txt)
#HUM=$(awk ' /Hudmidity/ {print substr ($0,0)}' /var/tmp/temp.txt)
#HUM=$(awk ' /Humidity/ {print 1$}' /var/tmp/temp.txt)
HUM=$(awk ' /Humidity/ {print substr ($0,27,2)}' /var/tmp/temp.txt)
echo $TEMP
echo $HUM
 
# Send data
curl -s -i -H "Accept: application/json"  "http://$SERVER/json.htm?type=command&param=udevice&idx=$DHTIDX&nvalue=0&svalue=$TEMP;$HUM;2"
 
 
TEMP=""
HUM=""
