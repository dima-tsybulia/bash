#!/bin/bash
# Written by Dmitry Tsybulia
# For personal use only
# v.0.0.43 - 01/28/2018

# Usage:
# ./show_configuration.sh > /tmp/show_configuration.log
# less -R /tmp/show_configuration.log

function is_root() {
	if [[ $EUID -ne 0 ]]; then
		tput setaf 1
   		echo "This script must be run as root!" 
   		tput sgr0
   		exit 1
	fi
}

function separator() {
	tput setaf 3
	echo "*********************************************************************"
	tput sgr0
}

is_root
separator

ip address
separator

if [ -f /etc/lsb-release ]; then
	more /etc/lsb-release 
fi
if [ -f /etc/redhat-release ]; then
	more /etc/redhat-release
fi
if [ -f /etc/SuSE-release ]; then
	more /etc/SuSE-release
fi
separator

uname -r
separator

lsblk -o NAME,UUID,FSTYPE,SIZE,MOUNTPOINT
separator

df -hT
separator

agent -v
separator

bsctl -v
separator

bsctl -l
if [[ $(ls -A | wc -c) -ne 0 ]]; then 
	echo "There are no attached devices."
fi
separator

/opt/apprecovery/scripts/agent_wrapper status
separator

service rapidrecovery-agent status
separator

service rapidrecovery-vdisk status
separator