#!/bin/bash


for (( i=1 ; i<=900 ; i++))
do
	mkdir demo$i
	cd demo$i 
	echo "File is $i" > demo.txt
	cd ..
done


