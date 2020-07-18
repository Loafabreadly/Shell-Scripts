#!/bin/bash
#V0.5
read -p 'Hostname: ' hostName
echo Setting hostname to $hostName
sudo hostnamectl set-hostname $hostName
sudo sed 's/satine/$hostName/g' /etc/hosts
echo
echo "Hostname Set!"
echo	
echo
echo "Fixing known Ubuntu1804 DNS issue"
echo
sudo rm /etc/resolv.conf
sudo ln -sf ../run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo systemctl restart resolvconf
read -p 'Please enter your desirec IP (10.0.50.x):' ip
echo
echo "Setting IP config"
echo
sed  's/10.0.50.30/$ip/g' /etc/netplan/50-cloud-init.yaml
echo "Applying IP configuration"
sudo netplan apply
echo
echo "Installing Script repository"
echo
sudo apt update
sudo apt install git
sudo git config --global user.name "Birdgeek"
sudo git config --global user.email "birdgeekthree@gmail.com"
sudo git config --list | grep user.
sudo git clone https://github.com/Birdgeek/Shell-Scripts.git
sudo chmod -R +x ./Shell-Scripts/
source ./Shell-Scripts/Ubuntu/installScripts.sh
clear
echo "Customization complete! Please reboot the system"


