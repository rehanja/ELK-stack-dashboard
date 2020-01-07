#!/bin/bash
# This is script can use to create 12 seperate hours timestamp log files in same day. 

for i in 0 1 2 3 4 5 6 7 8 9 10 11 
do
   	echo "START $i"
	sed 's/2019-11-22/2020-01-09/g' combined$i.log > output09_$i.log
	echo "BYE $i"
	echo "--------------"
done

