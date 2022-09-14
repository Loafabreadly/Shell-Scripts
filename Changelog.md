# Change Log
All notable changes to this project will be documented in this file.

## [V0.6] - 9-13-2022
### Added
- ./Ubuntu/resizeDisk.sh to resize the logical volume and filesystem to 100% Free. Commonly used after extending backing VM's disk

### Changed
- Refactored based off Git Username Change
- Modified ./Ubuntu/up.sh to use the changed APT command references for Ubuntu 22.04
- Modified ./PiHole/piup to no longer clone in a 3rd party dark UI as PiHole includes dark UI by default now
- Updated README

### Removed
- Removed vRNIC-NSX-Check.sh script as it does not relate to my HomeLab

## [V0.5] - 3-24-2021
### Added
- Added vRNIC-NSX-Check.sh version 1.0

### Changed
- Beefed up Update Mechnisms across all scripts
- Improved Catchall functionality for cmd execution failure

## [v0.4] - 7-18-2020
### Added
- Added ./Amp/restartADS.sh as a workaround to the current bug in v2.0.2
- Added ./Ubuntu/grp.sh to allow for auto Git Reset Pull
- Added ./Ubuntu/installScripts.sh as a way to auto-install all these scripts to be able to be called by their shorthand

### Changed
- Updated README

## [v0.3] - 7-17-2020
### Added
- Added ./Amp/ampdeploy.sh for deploy ability from raw Ubuntu1804 install

### Changed
- Refactored the Change Log
- Refactored ampupdate script
- Refactored piup script

## [v0.2] - 7-17-2020
### Added
- Added ./PiHole/piup.sh for intial update ability to all PiHole VM

### Changed
- Handling of how AMP calls the ampinstmgr
- Change Exit Script Function

## [v0.1] - 7-15-2020
### Added
- Added ./Amp/ampupdate.sh for intial update ability to all AMP instances