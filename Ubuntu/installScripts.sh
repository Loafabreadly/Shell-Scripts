#!/bin/bash
#Install Scripts Scipt
#v0.5
startInstall () {
	cd ~/Shell-Scripts/
	echo
	echo "Changing execute permissions for all scripts"
	echo
	sudo chmod +x -R ../Shell-Scripts/
	echo
	echo "Copying Scripts to bin"
	echo
	sudo cp Amp/ampupgrade.sh ~/bin/ampup
	sudo cp Amp/ampdeploy.sh ~/bin/ampdeploy
	sudo cp Amp/restartADS.sh ~/bin/adsr
	sudo cp PiHole/piup.sh ~/bin/piup
	sudo cp Ubuntu/grp.sh ~/bin/grp
	sudo cp Ubuntu/up.sh ~/bin/upds
	sudo cp Ubuntu/installScripts.sh ~/bin/reloadscripts
	sudo cp Ubuntu/customize.sh ~/bin/customizesys
	sudo cp Ubuntu/resizeDisk.sh ~/bin/resizedisk
	echo
	echo "Attempting to export variables"
	echo
	export PATH="~/bin:$PATH"
	source ~/.bashrc
}
mkdir -p ~/bin
startInstall