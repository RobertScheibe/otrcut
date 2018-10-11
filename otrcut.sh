#!/bin/bash
# (c) Robert Scheibe, 2016-02-23
# this script automatically downloads the topmost cutlist from cutlist.at for otrkey files
#u sing the otrdecoder executable from onlinetvrecorder.com

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters: please give the .otrkey filename"
    exit
fi

filename=$(basename $1)
fbname=${filename%.*}

email="youremail@somewhere.com"
pw="supersecurepassword"
echo "searching for $fbname.cut..."

rm cutfile.cut
wget -q -O cutfile.cut http://cutlist.at/getfile.php?id=`wget -q -O - http://cutlist.at/getxml.php?name=$fbname | xml2 | grep -m 1 id | cut -d= -f 2-`

if [ -s "cutfile.cut" ]
then
	otrdecoder -i $filename -U -C cutfile.cut -e $email -p $pw	
else 
	echo "no cutfile found."
	exit
fi
