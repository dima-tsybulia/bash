#! /bin/bash
# Written by Dmitry Tsybulia
# For personal use only (Softheme Internship)
# v.0.2.07 - 07/29/2017

if [ "$(whoami)" != "root" ]
then
	sudo su -s "$0"
exit
fi
echo "Do you want to see the list of your devices?"
echo "Press 1 - if YES, 0 -- if NO."
read choice_01
if [ "$choice_01" == "1" ]
then 
	echo "The list of disks:"
        echo "*********************************************************"
	fdisk -l /dev/sd?
	echo "*********************************************************"
elif [ "$choice_01" == "0" ]
then 
	echo "OK."
else
	exit
fi
echo "Enter the disk path (e.g. /dev/sda):"
read disk_path_01
echo "Enter the partition size (e.g. 100M):"
read partition_size
echo "Enter the file system type (e.g. ext2):"
read file_system_type
echo
echo "Menu:"
echo "*********************************************************"
echo "1. Create a primary partition of the specified size."
echo "2. Format the created partition to the specified file system type."
echo "3. Create a directory named like PARTITION_NAME-FILE_SYSTEM_TYPE_NAME in the /mnt catalog."
echo "4. Mount the created partition to the directoty."
echo "5. Add to the /etc/fstab a string for automatically mounting the partition."
echo "0. Exit."
echo "*********************************************************"
while true 
do
	echo "Enter desired functionality:"
	read choice_02
	if [ "$choice_02" == "1" ]
	then
		echo -e "n\np\n\n\n+$partition_size\nw" | fdisk $disk_path_01
		echo "*********************************************************"
		echo "The primary partition of the specified size has created."
	elif [ "$choice_02" == "2" ]
	then
		echo "*********************************************************"
		fdisk -l $disk_path_01
		echo "*********************************************************"
		echo "Enter the disk path:"
		read disk_path_02
		mount | grep "$disk_path_02" > /dev/null
		if [ $? -eq 0 ]
		then 
			echo "Unmounting $disk_path_02..."
			if umount "$disk_path_02"
			then
				echo "OK."
			else
				echo "Failed."
			fi
		fi		
		mkfs.$file_system_type $disk_path_02
	elif [ "$choice_02" == "3" ]
	then
		mkdir -p /mnt$disk_path_02-$file_system_type
	elif [ "$choice_02" == "4" ]
	then
		mount $disk_path_02 /mnt$disk_path_02-$file_system_type
	elif [ "$choice_02" == "5" ]
	then
		echo "$disk_path_02 /mnt$disk_path_02-$file_system_type $file_system_type defaults 0 0" >> /etc/fstab
	elif [ "$choice_02" == "0" ]
	then	
		exit
	fi
done


