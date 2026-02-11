#!/bin/bash


set -uo pipefail

USERNAME="Test File"

echo "User name is: $USERNAME"

false | true

echo $?



cleanup() {
	echo "Cleanuo"

}

restart() {
	echo "restarting"

}


trap 'echo "EXIT TRIGGEREDe"; cleanup; restart ' EXIT

trap 'echo "INT TRIGGERED""; exit 1' INT

trap 'echo "TERM TRIGGERED"; kill 0;exit 1' TERM

sleep 100



