#!/bin/bash

set -euo pipefail

LOG_FILE=/home/ec2-user/learn-devops/day5/backup.log


<< message
This script creates backup of the files
It will backup and will have last 5 backup files
message



log_csp() {
	printf '[%s] %s %s\n' "$(date '+%F %T')" "$1" "$2" >> "$LOG_FILE"
}



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

        		log_csp [ERROR] "Source path doesn't exist!!" "Check your path"
			exit 1
        fi
}

check_dpath() {

        if [ -d "${dest}" ]
        then    
                create_backups
        else    

			log_csp [ERROR]  "Destination path doesn't exist!!"
			exit 1
	fi
}

#creating backup
create_backups() {
        zip -r "${dest}/backup-$date.zip"  "${src}" >>/dev/null
        if [ $? -eq 0 ]
        then
                log_csp [INFO] "Backup created"

        else
                log_csp [ERROR] "Backup not created"
        fi


}
#deletes all the backups except the latest 5

perform_rotation() {
	IFS=$'\n'

	backups=($(ls -t ${dest}/backup-*.zip))

	
		if [ ${#backups[@]} -gt 5 ] 
		then
			log_csp [INFO] "Performing Rotation......"
		    	for o_backups in "${backups[@]:5}"
			do
		    		rm -f  "$o_backups"
			done
	        elif [ ${#backups[@]} -eq 0 ] 
	        then
			log_csp [ERROR] "No Backups Found!!"
		    	exit 1
		fi
	
}


function test() {
 	IFS=$'\n'
	backups=($(ls -t ${dest}/backup-*.zip))
printf  '%s\n' "${backups[@]}"
 
}


check_spath
perform_rotation

