#!/bin/bash

#Functions
check_exit_status() {

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
	echo "Hello, $USER. Running AMP Auto-Updater v0.2"
	echo
}

update() {

    sudo apt-get update;
	check_exit_status

    sudo apt-get upgrade -y;
	check_exit_status
}

housekeeping() {

	sudo apt-get autoremove -y;
	check_exit_status

	sudo apt-get autoclean -y;
	check_exit_status

	sudo updatedb;
	check_exit_status
}

endSystemUpdate() {

	echo
	echo "---------------------------"
	echo "- System Update Complete! -"
	echo "---------------------------"
	echo
}

ampUpdate() {
	sudo su - amp -c "ampinstmgr upgradeall;ampinstmgr startall"
}

exitScript() {
	clear
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