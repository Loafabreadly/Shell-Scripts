#!/bin/bash
#Install Scripts Scipt
#v0.1
startInstall () {
	
	cd ~/Shell-Scripts/
	sudo chmod +x -R ../Shell-Scripts/
	sudo cp Amp/ampupgrade.sh ~/bin/ampup
	sudo cp Amp/ampdeploy.sh ~/bin/ampdeploy
	sudo cp PiHole/piup.sh ~/bin/piup
	sudo cp Ubuntu/grp.sh ~/bin/grp
	ls -l ~/bin
	export PATH=~/bin:$PATH
	source ~/.bashrc
}

if [ -d "~/bin" ]
then
	startInstall
else
	mkdir ~/bin
fi

	startInstall

