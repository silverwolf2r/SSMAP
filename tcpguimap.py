#-------------tcpguimap.py---------------
#python program that gets the IP address data from a file and draws a redline on a downloaded google maps from my lat long to the latlog of the ip address.
#---------Uses file IPaddress.txt--------
import time
import pygeoip
import os
from os import system, name 
from requests import get
from gmplot import *

#Assign global variables
global srclo
global srcla



#use my geoip database
gi = pygeoip.GeoIP('GeoLiteCity.dat')

#get my External IP
myip = get('https://api.ipify.org').text
myip = str(myip)

#get my lat long
a = gi.record_by_addr(myip)
srclo = a.get('longitude')
srcla = a.get('latitude')

#assign x to exist
x = 0
lat = []
lon = []
yaddr = []


# make a list of ips that are unique/not repeated
def getip():
	with open('IPaddress.txt') as f:
	    iplist = f.readlines()
	return iplist
            
            
def locip(iplist):
	for ip in iplist:
		try:
			y = gi.record_by_addr(ip)
			ylo = y.get("longitude")
			yla = y.get("latitude")
			lat.append(yla)
			lon.append(ylo)
			if (y is not None):
				yaddr.append(ip.strip())     
		except:
			placeholder = 1

                
def plotpoint(lat, lon, yaddr):
	gmap = gmplot.GoogleMapPlotter(srcla, srclo, 4)
	#gmap.plot(lat, lon, 'cornflowerblue', edge_width = 2.5)
	gmap.scatter(lat, lon, '#FF0000',size = 50, title = yaddr, marker = True )
	gmap.apikey = "PUT_YOUR_API_KEY_HERE"
	gmap.draw( "/home/User/Tcpmap/Map.html" )


while x < 3:
	iplist = getip()
	locip(iplist)
	plotpoint(lat, lon, yaddr)
	time.sleep(5)
