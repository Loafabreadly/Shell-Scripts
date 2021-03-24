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
	echo "Hello, $USER. Running AMP Deployer v0.2"
	echo
}

update() {

    sudo apt-get update;
	checkExitStatus

    sudo apt-get upgrade -y;
	checkExitStatus
	
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
}

endSystemUpdate() {

	echo
	echo "---------------------------"
	echo "- System Update Complete! -"
	echo "---------------------------"
	echo
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

ampDeploy() {
	echo
	echo "Fixing known Ubuntu1804 DNS issue"
	echo
	sudo rm /etc/resolv.conf
	sudo ln -sf ../run/systemd/resolve/resolv.conf /etc/resolv.conf
	sudo systemctl restart resolvconf
	echo
	echo "Installing AMP"
	echo
	sudo su - root -c "bash <(wget -qO- getamp.sh)"
	

}

#Script
greeting
update
housekeeping
endSystemUpdate
ampDeploy
exitScript