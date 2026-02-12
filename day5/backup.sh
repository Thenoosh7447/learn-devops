#!/bin/bash

<< message
This script creates backup of the files
It will backup and will have last 5 backup files
message


s_usage() {

	echo "Usage:  ./backup.sh /source/path  destination/path "
}


if [ $# -eq 0 ]
then
	s_usage
fi

src=$1
dest=$2


date=$(date +%F-%H-%M-%S) 

create_backups() {
	zip -r "${dest}/backup-$date.zip"  "${src}" >>/dev/null 
	if [ $? -eq 0 ] 
	then
		echo "Backup created"

	else
		echo "Backup not created"
	fi


}

check_path() {

        if [ -e ${dest} ]
        then    
                create_backups
        else    

			echo "Destination path doesn'r exist!!"
	fi
}

perform_rotation() {
	backups=$(ls -t ${dest}/backup-*.zip)
	echo $backups
}



check_path
perform_rotation
