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
	sudo yum install -y unzip
	unzip awscliv2.zip
	sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
	echo "************Installed Amazon CLI*************"
}

create_instance() {
	local image_id=$1
	local instance_type=$2
	local key_name=$3
	local security_group_ids=$4
	local subnet_id=$5
	local instance_name=$6
	
instance=$(aws ec2 run-instances \
        --image-id $image_id \
        --count 1 \
        --instance-type $instance_type \
        --key-name $key_name \
        --security-group-ids $security_group_ids \
        --subnet-id $subnet_id \
	--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance_name}]" \
        --query 'Instances[0].InstanceId' \
        --output text
)
count=0
max_retry=10



while true; do
state=$(aws ec2 describe-instances \
	--instance-ids "$instance" \
	--query 'Reservations[0].Instances[0].State.Name' \
        --output text
)

if [ "$state" = "running" ];
then
        echo "Instance was created"
	break
else
        echo "Checking status"
fi

sleep 2

((count++))
if (( count >= max_retry ));
then
	echo "Error!! Status Check Timed Out"
	exit 1
fi


done

}




main() {
check_cli

       	amiId="ami-0ff5003538b60d5ec"
       	iType="t3.micro"
       	kName="test_mac_ssh"
       	sgId="sg-0e6f09bd1dc977535"
       	sId="subnet-07be38237f07674f2"
	iName="Test-server"

	create_instance "$amiId" "$iType" "$kName" "$sgId" "$sId" "$iName"
}

main

