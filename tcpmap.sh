# --------------------What everything does------------------------
# this program will get an IP database for use then it will run tcplocate.sh
# tcplocate.sh will get a tcp dump of any incoming and outgoing packets and then send them to the file IPaddress.txt
# tcpguimap.py will be running at the same time as this and will keep looking through the ipaddress file and make a html file that can be viewed through google maps


# The main program will act as a function
tcpmap () {

cd Tcpmap
#Have a databse which you can pull from for geo info
sudo rm -rf GeoLiteCity.dat
curl https://raw.githubusercontent.com/mbcc2006/GeoLiteCity-data/master/GeoLiteCity.dat >> GeoLiteCity.dat

#run tcplocate.sh
sh tcplocate.sh &  PIDMIX=$! 
python3 tcpguimap.py &  PIDMIX1=$!

wait $PIDMIX
wait $PIDMIX1


#delete the IPaddress file
sudo rm -rf IPaddress.txt
# delete the downloaded database
sudo rm -rf GeoLiteCity.dat
# delete the Map.html
sudo rm -rf Map.html

}





tcpstop () {
cd
cd Tcpmap
sudo rm -rf IPaddress.txt
sudo rm -rf GeoLiteCity.dat 
sudo rm -rf Map.html
sudo pkill tcpguimap.py

tcprocess="$(sudo ps aux | grep -m 1 tcp | awk '{print $2}')"
echo "$tcprocess"
sudo kill 17 "$tcprocess" 

cd
}
# ps aux | grep tcp
# sudo kill 17 PIDHERE


