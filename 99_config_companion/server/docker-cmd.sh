#!/bin/sh

CONFIG=$1

echo Startup, config file = $CONFIG

while true; do
	echo $(date) ----------------------------
	cat $CONFIG
	sleep 5
done