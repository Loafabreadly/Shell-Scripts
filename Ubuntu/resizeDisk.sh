#!/bin/bash

#Functions
echo
echo "Printing amount of space before operation"
echo
sudo df -h / | awk -F" " '{ print $4," " ,$3 }'
echo
echo "Extending Logical Volume"
echo
sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
echo
echo "Resizing the Filesystem"
echo
sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
echo
echo "Actions Completed!"
echo
echo "Printing amount of space after operation"
echo
sudo df -h / | awk -F" " '{ print $4," " ,$3 }'