#!/bin/bash
read -p 'Hostname: ' hostName
echo Setting hostname to $hostName
echo Running Hostnamectl
sudo hostnamectl set-hostname $hostName
echo Modifying Hosts file
sudo sed -i 's/satine/'$hostName'/g' /etc/hosts
echo
echo "Hostname Set!"
echo "Reboot once you are done"