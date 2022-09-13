#!/bin/bash
#V0.5
read -p 'Hostname: ' hostName
echo Setting hostname to $hostName
sudo hostnamectl set-hostname $hostName
sudo sed -i 's/satine/'$hostName'/g' /etc/hosts
echo
echo "Hostname Set!"
echo
read -p 'Please enter your desired IP (10.0.50.x):' ip
echo
echo "Setting IP config"
echo
sudo sed -i 's/10.0.50.30/'$ip'/' /etc/netplan/00-installer-config.yaml
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
echo "Customization complete! Please reboot the system"
sleep 3
echo "Applying IP configuration"
sudo netplan --debug apply
sleep 2
sudo reboot now


