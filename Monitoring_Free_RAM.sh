#!/bin/bash


# ****THIS IS A SIMPLE SCRIPT TO MONITOR THE FREE RAM****


FREE_SPACE=$(free -mt | grep "Total" | awk '{print $4}')

ALERT_BOUNDRY=500


if [[ $FREE_SPACE -lt $ALERT ]]
then
	echo -e "\e[31mWARANING, RAM IS RUNNING LOW\e[0m"
else 
	echo "RAM SPACE IS SUFFICIENT --> $FREE_SPACE"
fi


			
