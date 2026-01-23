#!/bin/bash


check_cli() {
	if command -v aws &>/dev/null; then
		echo "AWS CLI is installed ---" 
	else
		echo "AWS CLI isn't installed"
		install_cli
	fi
	
}


install_cli() {
	echo "*************** Insalling Amazon CLI............."
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
	echo "************Installed Amazon CLI*************"
}



check_cli


