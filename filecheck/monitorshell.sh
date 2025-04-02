#!/bin/bash

logfile="/var/log/integrity.log"
emailto="./emailreceiver.txt"
emailtemplate="./emailtemplate.txt"

monitorfile=$1

cd ~/scripts/filecheck

logentry() {
 echo "$(date +'%Y-%m-%d %H:%M:%S')" - $1 >> $logfile
}

emailalert() {
       while read -r recipient;
       do
	       ssmtp -v $recipient < $emailtemplate
	       logentry "Email notification sent to $recipient"
       done < "$emailto"
}

logentry "*---File Integrity Check service started for $1"
changed=0
while read -r line;
do 
   # Read each entry in monitorfile and check if file exist.
   # Log if file is not found else check if entry is existing in monitor.db
   # if entry is existing, check if hashsum has been changed else skip it
   
   if [ -e $line ]; 
   then
	   # get current hashsum for file 
	   cfilehash=$(sha256sum $line | cut -d" " -f1)
	   # if file already in db, compare the hashsum
	   if [[ $(cat monitor.db | grep $line | wc -l) -eq 1 ]];
	   then
		   hshvalue=$(cat monitor.db | grep $line | cut -d" " -f1)
		   filvalue=$(cat monitor.db | grep $line | cut -d" " -f3)
		   if [[ $hshvalue != $cfilehash ]];
	           then
                           changed=1
			   logentry "File $filvalue has been changed"
			   logentry "OldHash: $hshvalue"
			   logentry "NewHash: $cfilehash"
			   sed -i "s:$hshvalue:$cfilehash:g" monitor.db
			   logentry "New Hash updated"
			   emailalert
	           fi

	   else
		   logentry "Record Not Found - $line"
		   sha256sum $line >> "monitor.db"
           fi
   else
	   logentry "$line not found - skipping"
   fi
done < "$monitorfile"

if [[ $changed -eq 0 ]];
then
	logentry "No Changes Detected"
        logentry "*----File Integrity Check Service Ended"
        exit 0
fi
