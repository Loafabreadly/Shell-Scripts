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
	echo "Hello, $USER. Running Pi-Hole Auto-Updater v0.3"
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
	sudo aptautoclean -y;
	checkExitStatus
}

endSystemUpdate() {

	echo
	echo "---------------------------"
	echo "- System Update Complete! -"
	echo "---------------------------"
	echo
}

piholeUpdate() {

	sudo pihole -up
	checkExitStatus
}

piholeDark() {
	read -p "Do you want to install the Dark UI for PiHole? (yes/no)" answer
	if ["$answer" == "yes"]
	then
		echo "Installing Dark UI"
		cd /var/www/html/
		sudo wget https://raw.githubusercontent.com/lkd70/PiHole-Dark/master/install.sh
		sudo chmod +x install.sh
		sudo ./install.sh
	fi
}

exitScript() {
	echo
	echo "---------------------------"
	echo "- Pihole Update Completed -"
	echo "-      Exiting Script     -"
	echo "---------------------------"
	echo
	exit
}

#Script
greeting
update
housekeeping
endSystemUpdate
piholeUpdate
#piholeDark - No longer required as PiHole includes DarkUI options by default now
exitScript