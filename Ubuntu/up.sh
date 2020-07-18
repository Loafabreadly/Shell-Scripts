#!bin/bash

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
	echo "Hello, $USER. Running System  Updater v0.5"
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
	echo
	echo "Performing Distro Upgrades"
	echo
	sudo apt-get dist-upgrade -y;
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
}


#Script
