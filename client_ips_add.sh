#!/bin/bash

SECURITY_GROUP_ID="sg-0a6e6ff951bc730bb"
PROTOCOL="tcp"
PORT=443  

FILE="client_ips2.txt"
while IFS= read -r IP
do
  aws ec2 authorize-security-group-ingress --group-id "$SECURITY_GROUP_ID" --protocol "$PROTOCOL" --port "$PORT" --cidr "$IP/32"

  if [ $? -eq 0 ]; then
    echo "Successfully added $IP to the security group"
  else
    echo "Failed to add $IP to the security group"
  fi
done < "$FILE"
