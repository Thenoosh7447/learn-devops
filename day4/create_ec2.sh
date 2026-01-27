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


create_instance() {
aws ec2 run-instances \
       	--image-id ami-0ff5003538b60d5ec \
       	--count 1 \
       	--instance-type t3.micro \
       	--key-name test_mac_ssh \
	--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value="My-Test-Server"}]" \
       	--security-group-ids sg-0e6f09bd1dc977535 \
       	--subnet-id subnet-07be38237f07674f2 \
	--query 'Instances[0].InstanceId' \
	--output text
}


check_cli
create_instance

