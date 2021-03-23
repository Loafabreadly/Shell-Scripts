#!/bin/bash

#Functions
checkExitStatus() {
	if [$? -eq 0]
	then
		echo
		echo "Success"
		echo
	else
		echo
		echo "[ERROR] Process Failed!"
		echo
		read -p "The last command exited with an error. Exit script? (yes/no) " answer
		if ["$answer" == "yes"]
		then
			exit 1
		fi
	fi
}

#Inputs
prepEnv() {
	#Installs the Debian APT Source list for JQ install
	echo "Setting up APT Repositories and installing JQ for use with our API calls"
	sudo curl -k https://gist.githubusercontent.com/h0bbel/4b28ede18d65c3527b11b12fa36aa8d1/raw/314419c944ce401039c7def964a3e06324db1128/sources.list -o /etc/apt/sources.list
	sudo apt-get install jq -y
	read -p "Enter your CSP API Token: " CSPAPITOKEN
	echo "CSP API Token set to - $CSPAPITOKEN"
	read -p "Enter your ORG ID: " ORGID
	echo "ORG ID set to - $ORGID"
	read -p "Enter your SDDC ID: " SDDCID
	echo "SDDC ID set to - $SDDCID"
	export AUTH_HDR="Authorization: Bearer `curl https://console.cloud.vmware.com/csp/gateway/am/api/auth/api-tokens/authorize -d refresh_token=$APITOKEN | jq --raw-output '.access_token'`"
	export NSXRP="`curl -H "$AUTH_HDR" https://vmc.vmware.com/vmc/api/orgs/"$ORGID"/sddcs/"$SDDCID" | jq --raw-output '.resource_config.nsx_api_public_endpoint_url'`"
	echo "The NSX Reverse Proxy URL for the SDDC with ID $SDDCID is "
	echo "$NSXRP"
}

#Execute Script
prepEnv()
