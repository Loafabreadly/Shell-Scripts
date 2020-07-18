#!/bin/bash
#Install Scripts Scipt
#v0.1
if [ -d "~/bin" ]
then
	startInstall
else
	mkdir ~/bin
fi

	startInstall

startInstall () {
	
	cd ~/Shell-Scipts/
	sudo chmod +x -R ../Shell-Scipts/
	sudo cp Amp/ampupgrade.sh ~/bin/ampup
	sudo cp Amp/ampdeploy.sh ~/bin/ampdeploy
	sudo cp PiHole/piup.sh ~/bin/piup
	sudo cp Ubuntu/grp.sh ~/bin/grp
	ls -l ~/bin
	export PATH=~/bin:$PATH
	source ~/.bashrc
}