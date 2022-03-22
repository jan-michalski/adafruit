#!/bin/sh
 
# Domoticz server
SERVER="192.168.0.10:8080"
# DHT IDX
DHTIDX="2"
 
python3 /home/pi/adafruit/bmp180.py > /var/tmp/temp_bmp180.txt

TEMP=$(awk ' /Temp/ {print substr ($0,8,5)}' /var/tmp/temp_bmp180.txt)
echo $TEMP

PRESSURE=$(awk ' /Pressure/ {print substr ($0,12,3)}' /var/tmp/temp_bmp180.txt)
echo $PRESSURE
 
#TEMP=$(awk ' /Temp/ {print substr ($0,7,4)}' /var/tmp/temp_bmp180.txt)
#HUM=$(awk ' /Humidity/ {print substr ($0,12,2)}' /var/tmp/temp_bmp180.txt)
#echo $TEMP
#echo $HUM
 
# Send data
curl -s -i -H "Accept: application/json"  "http://$SERVER/json.htm?type=command&param=udevice&idx=$DHTIDX&nvalue=0&svalue=$TEMP;$PRESSURE;2"
#echo "Accept: application/json"  "http://$SERVER/json.htm?type=command&param=udevice&idx=$DHTIDX&nvalue=0&svalue=$TEMP;996;2"
 
#TEMP=""
#HUM=""
