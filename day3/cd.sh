#!/bin/bash

checkstatus=$1


if systemctl is-active --quiet  $checkstatus
then
	echo "$1 is running"

else
	echo "$1 is not running"
fi

