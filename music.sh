# !/bin/bash
# Written by Dmitry Tsybulia
# For personal use only
# v.0.1.23 - 12/25/2017

function is_root() {
	if [[ $EUID -ne 0 ]]; then
		tput setaf 1
   		echo "This script must be run as root!" 
   		tput sgr0
   		exit 1
	fi
}

function id3v2_installed() {
	id3v2_installed=`dpkg -l | grep id3v2 | awk '{print $2}'`
	if [ -z $id3v2_installed ]; then
		echo "*********************************************************************"
		tput setaf 1
		echo -e "The \"id3v2\" package is not installed! \nLet's install..."
		tput sgr0
		echo "*********************************************************************"
		apt install id3v2
	fi
}

function delete_tags() {
	for i in *.mp3
	do
		songs=$(echo "$PWD/${i}")
		id3v2 -D "${songs}"
	done
}

is_root
tput setaf 2
echo "This application is written for deleting ID3 tags"
echo "from mp3-files in the specified directory."
tput sgr0
id3v2_installed
echo "*********************************************************************"
tput setaf 2
echo "Current directory is $PWD."
tput sgr0
echo "*********************************************************************"
echo "| Press 1 - to proceed the operations with specified directory.     |"
echo "|-------------------------------------------------------------------|"
echo "| Press 2 - to change the current directory.                        |"
echo "*********************************************************************"
read choice
if [ "$choice" == 1 ]; then
	delete_tags
elif [ "$choice" == 2 ]; then
	echo "Enter the new directory:"
	read new_directory
	cd $new_directory
	delete_tags
else
	exit 0
fi
