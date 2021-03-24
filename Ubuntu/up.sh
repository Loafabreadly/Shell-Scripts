#!/bin/bash

#Functions
checkExitStatus() {

	if [ $? -eq 0 ]
	then
		echo
		echo "Success"
		echo
	else
		echo
		echo "[ERROR] Process Failed!"
		echo
		
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
    sudo apt-get update;
	checkExitStatus
	echo
	echo "Upgrading packages"
	echo
    sudo apt-get upgrade -y;
	checkExitStatus
	read -p "Do you want to upgrade the Distro OS? (yes/no) " answer
	if ["$answer" == "yes"]
	then
		echo "Performing Distro Upgrades"
		echo
		echo
		sudo apt-get dist-upgrade -y;
		checkExitStatus	
	fi
}

housekeeping() {
	echo
	echo "Auto Removing old packages"
	echo
	sudo apt-get autoremove -y;
	checkExitStatus
	echo
	echo "Running APT Auto-clear"
	echo
	sudo apt-get autoclean -y;
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
	if ["$answer" == "yes"]
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
