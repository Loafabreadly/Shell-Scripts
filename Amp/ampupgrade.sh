#!/bin/bash
clear

echo "Upgrading AMP script v0.1"

sudo apt-get update
sudo apt-get upgrade
sudo su -l amp
ampinstmgr upgradeall
ampinstmgr startall
exit
echo "***********************"
echo "* Completed Amp Update*"
echo "***********************"