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
	echo "Hello, $USER. Running Pi-Hole Auto-Updater v0.2"
	echo
}

update() {

    sudo apt-get update;
	checkExitStatus

    sudo apt-get upgrade -y;
	checkExitStatus
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
	echo
	echo "Updating APT DB"
	echo
	sudo updatedb;
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

	cd /var/www/html/
	sudo wget https://raw.githubusercontent.com/lkd70/PiHole-Dark/master/install.sh
	sudo chmod +x install.sh
	sudo ./install.sh

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
piholeDark
exitScript