#!/bin/bash


#check result



function check_marks() {

read -p "Enter Jetha Marks1: " m1
read -p "Enter Jetha Marks1: " m2



if [[ $m1 -lt 35 || $m2 -lt 35 ]];
then
	echo "Failed"
else
	if [[ $(( m1+m2 )) -ge 75 ]];
	then
		echo "Passed with Distinction"
	elif [[ $(( m1+m2 )) -lt 35 ]];
	then
		echo "Failed"
	else
		echo "Passed with okay marks"
	fi
fi

}

check_marks

