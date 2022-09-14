#!/bin/bash
#GRP = Git Reset Pull
# v0.1
cd Shell-Scripts/
sudo git reset --hard
sudo git pull
sudo chmod +x -R ../Shell-Scripts/
cd ~
~/Shell-Scripts/Ubuntu/installScripts.sh #Installs  the updated commands. We need to call the sh file direct in case itself had a change in the recent commits
