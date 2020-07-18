#!/bin/bash
#V0.5
echo
echo "Please enter your desired hostname"
read hostname
echo
echo "Setting hostname to $hostName"
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
echo "Please enter your desirec IP (10.0.50.x):"
read ip
echo
echo "Setting IP config"
echo
sed  's/10.0.50.30/$ip/g' /etc/netplan/50-cloud-init.yaml
echo "Applying IP configuration"
sudo netplan apply
echo
echo "Installing Script repository"
echo
sudo git clone https://github.com/Birdgeek/Shell-Scripts.git
sudo chmod -R +x ./Shell-Scripts/
source ./Shell-Scripts/Ubuntu/installScripts.sh
clear
echo "Customization complete! Please reboot the system"


