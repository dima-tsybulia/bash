# !/bin/bash
# Written by Dmitry Tsybulia
# For personal use only (Xubuntu 17.10)
# v.0.4.67 - 01/21/2018

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

packages_for_installing=(chromium-browser screenfetch tree gparted markdown mc htop glances pinta default-jre xfce4-pulseaudio-plugin gufw virtualbox-5.2 telegram sublime-text-installer)

for package in "${packages_for_installing[@]}"; do
	apt install $package -y
done

echo "blacklist btusb" >> /etc/modprobe.d/blacklist.conf

apt upgrade

echo "" > ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
sed -i '1 i {                                                 \
	"fallback_encoding": "Cyrillic (Windows 1251)",       \
	"ignored_packages": [ "Vintage" ],                    \
	"update_check": false                                 \
}' ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings

wget https://packagecontrol.io/Package%20Control.sublime-package -P ~/.config/sublime-text-3/Installed\ Packages

wget https://github.com/dmitry-tsybulia/bash/raw/master/MarkdownEditing.sublime-package -P ~/.config/sublime-text-3/Installed\ Packages

wget https://github.com/dmitry-tsybulia/bash/raw/master/License.sublime_license -P ~/.config/sublime-text-3/Local

echo "" > ~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
sed -i '1 i {                                                 \
	"bootstrapped": true,                                 \
	"in_process_packages": [],                            \
	"installed_packages":                                 \
	[                                                     \
		"MarkdownEditing",                            \
		"Package Control"                             \
	]                                                     \
}' ~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
