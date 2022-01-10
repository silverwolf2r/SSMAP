# this will perform the tcp dump and get the ip information 

#get current geoip database before running


while :
do
#get all connections to the computer and grep for IPv4 addresses
ss --all -4 | grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" >> IPaddress.txt

# uniq the file and store in variable
x="$(sort -u IPaddress.txt)"

# clear out the file
uniq IPaddress.txt IPaddress.txt

#rewrite the uniq items to the file
echo "$x" >> IPaddress.txt

done
