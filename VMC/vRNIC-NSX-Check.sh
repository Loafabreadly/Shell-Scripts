#!/usr/bin/env bash
#Name: vRNIC-NSX-Check
#Author: Brad Snurka
#Purpose: Checks commonly faced issues when attempting to add a vRNI/vRNIC Collector VM to a VMC Environment. Checks that the required prerequisites are met via API calls
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
	clear
	#Installs the Debian APT Source list for JQ install
	echo -e "\nSetting up APT Repositories and installing JQ for use with our API calls\n"
	sudo curl -k https://gist.githubusercontent.com/h0bbel/4b28ede18d65c3527b11b12fa36aa8d1/raw/314419c944ce401039c7def964a3e06324db1128/sources.list -o /etc/apt/sources.list
	sudo apt-get install jq -y
	read -p "Enter your CSP API Token: " CSPAPITOKEN
	echo -e "CSP API Token set to - $CSPAPITOKEN"
	read -p "Enter your ORG ID: " ORGID
	echo -e "ORG ID set to - $ORGID"
	read -p "Enter your SDDC ID: " SDDCID
	echo -e "SDDC ID set to - $SDDCID"
	AUTH_HDR="Authorization: Bearer `curl https://console.cloud.vmware.com/csp/gateway/am/api/auth/api-tokens/authorize -d refresh_token=$CSPAPITOKEN| jq --raw-output '.access_token'`"
	echo -e "\nGenerating SDDC JSON to extract info"
	curl -H "$AUTH_HDR" https://vmc.vmware.com/vmc/api/orgs/"$ORGID"/sddcs/"$SDDCID" -o sddcjson.json
	echo -e "\nGrabbing SDDC Name & Version"
	SDDCNAME="`cat sddcjson.json | jq --raw-output '.name'`"
	SDDCVER="`cat sddcjson.json | jq --raw-output '.resource_config.vmc_version'`"	
	echo -e "\nGrabbing NSX Reverse Proxy URL & Private IP"
	NSXRP="`cat sddcjson.json | jq --raw-output '.resource_config.nsx_api_public_endpoint_url'`"
	NSXIP="`cat sddcjson.json | jq --raw-output '.resource_config.nsx_mgr_management_ip'`"
	NSXFQDN="`cat sddcjson.json | jq --raw-output '.resource_config.nsx_mgr_url'` | awk -F/ '{print $3}'"
	echo -e "\nGrabbing vCenter FQDN & IP Information"
	VCPRIVATEIP="`cat sddcjson.json | jq --raw-output '.resource_config.vc_management_ip'`"
	VCPUBLICIP="`cat sddcjson.json | jq --raw-output '.resource_config.vc_public_ip'`"
	VCFQDN="`cat sddcjson.json | jq --raw-output '.resource_config.vc_url'` | awk -F/ '{print $3}'"
}

runVCChecks() {
	echo -e "\nRunning CURL to test 443 inbound access to vCenter"
	echo -e "\n\nTesting Private IP"
	reply="`curl -v -k telnet://"$VCPRIVATEIP":443`"
	echo "$reply"
	sleep 2
	echo -e "\n\nTesting Public IP"
	reply="`curl -v -k telnet://"$VCPUBLICIP":443`"
	echo "$reply"
	sleep 2
	echo -e "\n\nTesting FQDN"
	reply="`curl -v -k telnet://"$VCFQDN":443`"
	echo "$reply"
	sleep 2
	echo -e "\nTests Complete\nWe would expect 1 of the IP CURLs to fail as VC can only resolve over one IP types at a time"
	read -p "Did more than 1 of the CURL attempts above fail? (yes/no)" answer
	if ["$answer" == "yes"]
	then
		echo -e "\nThis likely means you are missing some required MGW FW rules allowing connections between the Collector and SDDC vCenter. Please resolve & re-test"
		echo -e "\nPress any key to quit"
		while [true]; do
			read -t 1 -n 1
			if [$? = 0]; then
				exit
			fi
		done
	fi
}

runNSXChecks() {
	echo -e "\nRunning CURL to test 443 inbound access to NSX Manager"
	echo -e "\n\nTesting Private IP"
	reply="`curl -v -k telnet://"$NSXIP":443`"
	echo "$reply"
	sleep 2
	echo -e "\n\nTesting FQDN"
	reply="`curl -v -k telnet://"$NSXFQDN":443`"
	echo "$reply"
	sleep 2
	echo -e "\nTests Complete\n"
	read -p "Did either of the above CURL attempts fail? (yes/no)" answer
	if ["$answer" == "yes"]
	then
		echo -e "\nThis likely means you are missing some required MGW FW rules allowing connections between the Collector and SDDC NSX Manager. Please resolve & re-test"
		echo -e "\nPress any key to quit"
		while [true]; do
			read -t 1 -n 1
			if [$? = 0]; then
				exit
			fi
		done
	fi
	sleep 3
	echo -e "\nExecuting API Calls to test if NSX Manager responds as expected"
	echo -e "\n\nTesting NSX Reverse Proxy Call"
	curl -i -k -H 'Content-Type: application/json' -H "$AUTH_HDR" -X GET $NSXRP/policy/api/v1/infra/sites/default/enforcement-points
	sleep 2
	echo -e "\n\nTesting NSX Private IP Call"
	curl -i -k -H 'Content-Type: application/json' -H "$AUTH_HDR" -X GET https://"$NSXIP"/policy/api/v1/infra/sites/default/enforcement-points
	sleep 2
	echo -e "\nTests completed, there should be two instances of the same enforcement-points data printed"
	echo -e "\nIf neither worked, assume the CSP API Token is bad and re-generate a new token, potentially specifying ALL ROLES as a sanity check"
	echo -e "\nIf the Private IP lookup worked but Reverse Proxy did not, assume a DNS issue."
	echo -e "\nIf the Reverse Proxy lookup worked but the private IP one did, contact VMC Support."
	sleep 10
	echo -e "Testing NSX-T Manager's API Reply using Reverse Proxy"
	sleep 1
	echo -e "\nNode Test"
	curl -i -k -H 'Content-Type: application/json' -H "$AUTH_HDR" -X GET $NSXRP/policy/api/v1/node
	sleep 1
	echo -e "\nHosts Test"
	curl -i -k -H 'Content-Type: application/json' -H "$AUTH_HDR" -X GET $NSXRP/policy/api/v1/fabric/nodes
	sleep 1
	echo -e "\nFirewall Status Test"
	curl -i -k -H 'Content-Type: application/json' -H "$AUTH_HDR" -X GET $NSXRP/policy/api/v1/firewall/status	
}

#Execute Script
prepEnv
runVCChecks
runNSXChecks