#!/bin/bash
#Install Scripts Scipt
#v0.1
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
	sudo cp Ubuntu/up.sh ~/bin/up
	ls -l ~/bin
	echo "Attempting to export variables"
	echo "If this doesn't work, run the following"
	echo "export PATH=~/bin:'$PATH'"
	echo "source ~/.bashrc"
	export PATH="~/bin:$PATH"
	source ~/.bashrc
}

if [ -d "~/bin" ]
then
	startInstall
else
	mkdir ~/bin
	startInstall
fi

	

