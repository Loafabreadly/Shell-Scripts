# Snurka Shell Script Repository :bread:
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/Loafabreadly/Shell-Scripts/issues)
## Description
This GitHub repository houses various in-house scripts used within the HomeLab environment. So far, only Bash scripts designed for Ubuntu 22.04 LTS is supprted.
### AMP Scripts :electron:
Read more about AMP [Here](https://cubecoders.com)
* ```./Amp/ampupdate.sh``` - Script to auto-update the System as well as all AMP instances for the main stream releases. (Called by ```ampup``` command)
* ```./Amp/ampdeploy.sh``` - Script to auto-deploy the AMP service to a fresh Ubuntu 1804 VM. Includes various hotfixes for known Ubuntu issues prior to install

### Pi-Hole Scripts :pie:
* ```./PiHole/piup.sh``` - Script to auto-update the System as well as PiHole. (Called by ```piup``` command)

### Ubuntu Scripts :penguin:
* ```./Ubuntu/installScripts.sh``` - Script to install all the scripts! Script-ception! (Called by ```reloadscripts``` command)
* ```./Ubuntu/grp.sh``` - Git Reset Pull on the Shell Scripts repo to auto-pull updates (Called by ```upds``` command)
* ```./Ubuntu/up.sh``` - Updates System - (Called by ```upds``` command)
* ```./Ubuntu/resizeDisk.sh``` - resize the logical volume and filesystem to 100% Free - (Called by ```resizedisk``` command)

## Installation
Clone the Repository, modify to allow for script execution, run the install script

```bash
sudo git clone https://github.com/Loafabreadly/Shell-Scripts.git
sudo chmod -R +x ./Shell-Scripts/
source ./Shell-Scripts/Ubuntu/installScripts.sh
```
# [Change log](https://github.com/Loafabreadly/Shell-Scripts/blob/master/Changelog.md)
