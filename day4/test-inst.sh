#!/bin/bash





aws ec2 describe-instances --instance-ids "i-0468ee53b31e85b61" --query 'Reservations[0].Instances[0].State.Name'
