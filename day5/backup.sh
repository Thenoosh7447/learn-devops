#!/bin/bash

set -euo pipefail

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
	exit 1
fi

src=$1
dest=$2


date=$(date +%F-%H-%M-%S) 

#checks if the path exits

check_spath() {

        if [ -d "${src}" ]
        then
                check_dpath
        else

                        echo "Source path doesn't exist!!"
			exit 1
        fi
}

check_dpath() {

        if [ -d "${dest}" ]
        then    
                create_backups
        else    

			echo "Destination path doesn't exist!!"
			exit 1
	fi
}

#creating backup
create_backups() {
        zip -r "${dest}/backup-$date.zip"  "${src}" >>/dev/null
        if [ $? -eq 0 ]
        then
                echo "Backup created"

        else
                echo "Backup not created"
        fi


}
#deletes all the backups except the latest 5

perform_rotation() {
	backups=($(ls -t ${dest}/backup-*.zip))

	
		if [ ${#backups[@]} -gt 5 ] 
		then
			echo "Performing Rotation......"
		    	delete_backups="${backups[@]:5}"
		    	rm  ${delete_backups[@]}
	        elif [ ${#backups[@]} -eq 0 ] 
	        then
			echo "No Backups Found!!"
		    	exit 1
		fi
	
}


check_spath
perform_rotation
