#!/bin/bash




useradd() {
	# read -p "Enter the user to add: " username
	sudo useradd $1
}



if ! useradd $1; then
	echo "User already exists"
	exit 0
fi

echo "User added successfully"
