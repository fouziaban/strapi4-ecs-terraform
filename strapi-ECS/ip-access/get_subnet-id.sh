#!/bin/bash

# Ensure jq is executable
if ! command -v jq &> /dev/null
then
    echo "jq could not be found"
    exit 1
fi

# Parse input variables
VPC_ID=$(jq -r .vpc_id)
SUBNET_CIDRS=$(jq -r .subnet_cidrs | jq -c '.[]')

SUBNET_IDS=()

# Loop through CIDR blocks to get Subnet IDs
for CIDR in $SUBNET_CIDRS; do
  CIDR=$(echo $CIDR | tr -d '"')
  SUBNET_ID=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" "Name=cidr-block,Values=$CIDR" --query "Subnets[0].SubnetId" --output text)
  SUBNET_IDS+=($SUBNET_ID)
done

# Output Subnet IDs as JSON
jq -n --argjson subnet_ids "$(printf '%s\n' "${SUBNET_IDS[@]}" | jq -R . | jq -s .)" '{"subnet_ids":$subnet_ids}'
