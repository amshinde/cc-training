#!/bin/sh
if [ $(id -u) -eq 0 ]; then
	echo "Sorry, you cannot run this as root."
	exit 1
fi

ssh -t 192.168.120.10 "sudo shutdown -h now"
ssh -t 192.168.120.11 "sudo shutdown -h now"
echo "Waiting for VMs to shutdown..."
sleep 10
ps ax | grep qemu 

