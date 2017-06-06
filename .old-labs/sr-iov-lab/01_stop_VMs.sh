#!/bin/sh
if [ $(id -u) -eq 0 ]; then
	echo "Sorry, you cannot run this as root."
	exit 1
fi

ssh -t 192.168.120.10 "sudo shutdown -h now"
ssh -t 192.168.120.11 "sudo shutdown -h now"

#PS_SEARCH=qemu

get_pids() 
{
	ps ax | grep $1 | awk '{ print $1}'
}

#get_pids $PS_SEARCH | while read PID; do
#	kill -9 $PID
#done

