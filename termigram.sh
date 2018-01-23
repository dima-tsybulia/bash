#!/bin/bash
# Written by Dmitry Tsybulia
# For personal use only
# v.0.0.37 - 01/23/2018

argument=$1

function is_root() {
	if [[ $EUID -ne 0 ]]; then
		tput setaf 1
   		echo "This script must be run as root!" 
   		tput sgr0
   		exit 1
	fi
}

is_root

function termigram_install() {
	apt install python
	sudo -H pip install python-telegram-bot
	sudo -H pip install appdirs
	python setup.py install
	tput setaf 2
   	echo -e "Termigram is installed!"
   	tput sgr0
	termigram --configure
}

function termigram_uninstall() {
	termigram --clean
	tput setaf 2
   	echo "Termigram configuration file is removed!"
   	tput sgr0
	sudo -H pip uninstall termigram -y
	rm -f /usr/local/bin/termigram
	sudo -H pip uninstall python-telegram-bot -y
	sudo -H pip uninstall appdirs -y
	apt autoremove
	tput setaf 2
   	echo "Termigram is uninstalled!"
   	tput sgr0
}

if [ "$argument" = "--install" ] || [ "$argument" = "-i" ]
then
	termigram_install
	exit 0	
fi

if [ "$argument" = "--uninstall" ] || [ "$argument" = "-u" ]
then
	termigram_uninstall
	exit 0	
fi