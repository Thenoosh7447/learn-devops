#!/bin/bash


checknum() {
read -p "Enter number: " number

if [[ $number%2 -eq 0  ]]
then
	echo "Even"
else
	echo "Odd"
fi
}


if ! checknum; then
	echo "Enter an whole number"
	exit 1
fi


