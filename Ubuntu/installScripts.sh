#!/bin/bash
#Install Scripts Scipt
#v0.5
startInstall () {
	
	cd ~/Shell-Scripts/
	echo "Changing execute permissions for all scripts"
	sudo chmod +x -R ../Shell-Scripts/
	echo "Copying Scripts to bin"
	sudo cp Amp/ampupgrade.sh ~/bin/ampup
	sudo cp Amp/ampdeploy.sh ~/bin/ampdeploy
	sudo cp Amp/restartADS.sh ~/bin/adsr
	sudo cp PiHole/piup.sh ~/bin/piup
	sudo cp Ubuntu/grp.sh ~/bin/grp
	sudo cp Ubuntu/up.sh ~/bin/upds
	sudo cp Ubuntu/installScripts.sh ~/bin/reloadscripts
	echo "Attempting to export variables"
	export PATH="~/bin:$PATH"
	source ~/.bashrc
}

if [ ! -d "~/bin/" ] 
then
	echo "Bin doesn't exist"
	mkdir ~/bin
	startInstall
else
	startInstall
fi

	

