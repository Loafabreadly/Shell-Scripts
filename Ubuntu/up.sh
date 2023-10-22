#!/bin/bash

# Define color codes
RED='\033[31m'
GREEN='\033[32m'
RESET='\033[0m'

#Functions
checkExitStatus() {
	if [ $? -eq 0 ]
	then
		echo -e "\n${GREEN}Success${RESET}\n"
	else
		echo -e "\n[${RED}ERROR}${RESET}] Process Failed!\n"
		read -p "The last command exited with an error. Exit script? (yes/no) " answer
		if [ "$answer" == "yes" ]
		then
			exit 1
		fi
	fi
}

greeting() {
	echo
	echo -e "Hello, ${GREEN}$USER.${RESET} Running System  Updater ${GREEN}v0.7${RESET}"
	echo
}

update() {
	echo -e "Updating packages\n"
  sudo apt update;
	checkExitStatus
	echo -e "Upgrading packages\n"
  sudo apt upgrade -y;
	checkExitStatus
	read -p "Do you want to upgrade the Distro OS? (yes/no) " answer
	if [ "$answer" == "yes" ]
	then
		echo -e "Performing Distro Upgrades\n"
		sudo apt dist-upgrade -y;
		checkExitStatus	
	fi
}

housekeeping() {
	echo -e "Auto Removing old packages\n"
	sudo apt autoremove -y;
	checkExitStatus
	echo -e "Running APT Auto-clear\n"
	sudo apt autoclean -y;
	checkExitStatus
}

endSystemUpdate() {

	echo -e "\n---------------------------"
	echo -e "- ${GREEN}System Update Complete!${RESET} -"
	echo -e "-      ${GREEN}Please Reboot${RESET}      -"
	echo -e "---------------------------\n"
}

exitScript() {
	echo -e "\n--------------------"
	echo -e "- ${GREEN}Update Completed${RESET}-"
	echo -e "-  ${GREEN}Exiting Script${RESET}  -"
	echo -e "--------------------\n"
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
