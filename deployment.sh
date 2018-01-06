#!/bin/bash
# Written by Dmitry Tsybulia
# For personal use only (Xubuntu 17.10)
# v.0.3.26 - 01/06/2018

function is_root() {
	if [[ $EUID -ne 0 ]]; then
		tput setaf 1
   		echo "This script must be run as root!" 
   		tput sgr0
   		exit 1
	fi
}

is_root

packages_for_purging=(thunderbird* gnome-mines gnome-sudoku libreoffice* simple-scan gigolo sgt-launcher sgt-puzzles xfce4-notes pidgin firefox* onboard* xfce4-dict)

for package in "${packages_for_purging[@]}"; do
	apt purge $package -y
done

apt autoremove -y

ppa_for_adding=(atareao/telegram webupd8team/sublime-text-3)

for ppa in "${ppa_for_adding[@]}"; do
	add-apt-repository ppa:$ppa -y
done

apt update

packages_for_installing=(chromium-browser screenfetch tree gparted markdown mc htop glances pinta default-jre xfce4-pulseaudio-plugin virtualbox-5.2 telegram sublime-text-installer)

for package in "${packages_for_installing[@]}"; do
	apt install $package -y
done

echo "blacklist btusb" >> /etc/modprobe.d/blacklist.conf

apt upgrade