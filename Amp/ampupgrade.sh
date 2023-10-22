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
		echo -e "\n[${RED}ERROR${RESET}] Process Failed!\n"
		read -p "The last command exited with an error. Exit script? (yes/no) " answer
		if [ "$answer" == "yes" ]
		then
			exit 1
		fi
	fi
}

greeting() {

	echo
	echo -e "Hello, ${GREEN}$USER.${RESET} Running AMP Auto-Updater ${GREEN}v0.6${RESET}"
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

	echo -e "\n---------------------------"
	echo -e "- ${GREEN}System Update Complete!${RESET} -"
	echo -e "-      ${GREEN}Please Reboot${RESET}      -"
	echo -e "---------------------------\n"
}

ampUpdate() {
	sudo su - amp -c "ampinstmgr upgradeall"
}

exitScript() {
	echo -e "\n------------------------"
	echo -e "- ${GREEN}AMP Update Completed${RESET} -"
	echo -e "-    ${GREEN}Exiting Script${RESET}    -"
	echo -e "------------------------\n"
	exit
}

#Script
greeting
update
housekeeping
endSystemUpdate
ampUpdate
exitScript