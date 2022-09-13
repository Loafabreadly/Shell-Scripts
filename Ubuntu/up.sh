#!/bin/bash

#Functions
checkExitStatus() {
	if [ $? -eq 0 ]
	then
		echo -e "\nSuccess\n"
	else
		echo -e "\n[ERROR] Process Failed!\n"
		read -p "The last command exited with an error. Exit script? (yes/no) " answer
		if [ "$answer" == "yes" ]
		then
			exit 1
		fi
	fi
}

greeting() {

	echo
	echo "Hello, $USER. Running System  Updater v0.6"
	echo
}

update() {

	echo
	echo "Updating packages"
	echo
    sudo apt update;
	checkExitStatus
	echo
	echo "Upgrading packages"
	echo
    sudo apt upgrade -y;
	checkExitStatus
	read -p "Do you want to upgrade the Distro OS? (yes/no) " answer
	if [ "$answer" == "yes" ]
	then
		echo "Performing Distro Upgrades"
		echo
		echo
		sudo apt dist-upgrade -y;
		checkExitStatus	
	fi
}

housekeeping() {
	echo
	echo "Auto Removing old packages"
	echo
	sudo apt autoremove -y;
	checkExitStatus
	echo
	echo "Running APT Auto-clear"
	echo
	sudo apt autoclean -y;
	checkExitStatus
}

endSystemUpdate() {

	echo
	echo "---------------------------"
	echo "- System Update Complete! -"
	echo "-      Please Reboot      -"
	echo "---------------------------"
	echo
}

exitScript() {
	echo
	echo "--------------------"
	echo "- Update Completed -"
	echo "-  Exiting Script  -"
	echo "--------------------"
	echo
	exit
	read -p "Do you wish to reboot now? (yes/no) " answer
	if [ "$answer" == "yes" ]
	then
		sudo reboot now
	fi
}


#Script
greeting
update
housekeeping
endSystemUpdate
exitScript
