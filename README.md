# Snurka Shell Script Repository :bread:
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/Birdgeek/Shell-Scripts/issues)
## Description
This GitHub repository houses various in-house scripts used within the HomeLab environment. So far, only Bash scripts designed for Ubuntu 18.04 LTS is supprted.
### AMP Scripts :electron:
Read more about AMP [Here](https://cubecoders.com)
* ./Amp/ampupdate.sh - Script to auto-update the System as well as all AMP instances for the main stream releases.
* ./Amp/ampdeploy.sh - Script to auto-deploy the AMP service to a fresh Ubuntu 1804 VM. Includes various hotfixes for known Ubuntu issues prior to install
* ./Amp/restartADS.sh - Script used to restart the main "ADS01" instance manager when the know bug of login request flooding (affecting v2.0.2 of AMP) prevents user login
### Pi-Hole Scripts :pie:
* ./PiHole/piup.sh - Script to auto-update the System as well as PiHole. Replaces PiHole default CSS with DarkMode cloned from [this](https://github.com/lkd70/PiHole-Dark) repo

### Ubuntu Scripts :penguin:
* ./Ubuntu/installScripts.sh - Script to install all the scripts! Script-ception!
* ./Ubuntu/grp.sh - Git Reset Pull on the Shell Scripts repo to auto-pull updates

## Installation
Clone the Repository, modify to allow for script execution, run the install script

```bash
sudo git clone https://github.com/Birdgeek/Shell-Scripts.git
sudo chmod -R +x ./Shell-Scripts/
source ./Shell-Scripts/Ubuntu/installScripts.sh
```
# [Change log](https://github.com/Birdgeek/Shell-Scripts/blob/master/Changelog.md)
