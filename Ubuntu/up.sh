#!/bin/bash

# Define color codes
RED='\033[31m '
GREEN='\033[32m '
RESET='\033[0m '

#Functions
checkExitStatus() {
	if [ $? -eq 0 ]
	then
		echo -e "\n${GREEN}Success${RESET}\n"
	else
		echo -e "\n[${RED}ERROR}${RESET}] Process Failed!\n"
		read -p "The last command exited with an error. ${RED}Exit script?${RESET} (${GREEN}yes${RESET}/${RED}no${RESET}) " answer
		if [ "$answer" == "yes" ]
		then
			exit 1
		fi
	fi
}

greeting() {

	echo
	echo "Hello, ${GREEN}$USER.${RESET} Running System  Updater ${GREEN}v0.7${RESET}"
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
	read -p "Do you want to upgrade the Distro OS? (${GREEN}yes${RESET}/${RED}no${RESET}) " answer
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
	echo "- ${GREEN}System Update Complete!${RESET} -"
	echo "-      ${GREEN}Please Reboot${RESET}      -"
	echo "---------------------------"
	echo
}

exitScript() {
	echo
	echo "--------------------"
	echo "- ${GREEN}Update Completed${RESET}-"
	echo "-  ${GREEN}Exiting Script${RESET}  -"
	echo "--------------------"
	echo
	exit
	read -p "Do you wish to reboot now? (${GREEN}yes${RESET}/${RED}no${RESET}) " answer
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
