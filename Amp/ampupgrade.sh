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
	echo "Hello, $USER. Running AMP Auto-Updater v0.4"
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
	echo "- System Update Complete! -"
	echo "---------------------------"
	echo
}

ampUpdate() {
	sudo su - amp -c "ampinstmgr upgradeall"
}

exitScript() {
	echo
	echo "------------------------"
	echo "- AMP Update Completed -"
	echo "-    Exiting Script    -"
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