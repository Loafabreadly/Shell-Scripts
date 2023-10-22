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
		read -p "The last command exited with an error. ${RED}Exit script?${RESET} (${GREEN}yes${RESET}/${RED}no${RESET}) " answer
		if [ "$answer" == "yes" ]
		then
			exit 1
		fi
	fi
}

greeting() {

	echo
	echo "Hello, ${GREEN}$USER.${RESET} Running AMP Auto-Updater ${GREEN}v0.6${RESET}"
	echo
}

update() {

    sudo apt update;
	checkExitStatus

    sudo apt upgrade -y;
	checkExitStatus
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

ampUpdate() {
	sudo su - amp -c "ampinstmgr upgradeall"
}

exitScript() {
	echo
	echo "------------------------"
	echo "- ${GREEN}AMP Update Completed${RESET} -"
	echo "-    ${GREEN}Exiting Script${RESET}    -"
	echo "------------------------"
	echo
	exit
}

#Script
greeting
update
housekeeping
endSystemUpdate
ampUpdate
exitScript