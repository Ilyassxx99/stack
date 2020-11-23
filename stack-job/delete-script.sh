#!/bin/bash
#Set AWS credentials
aws configure set default.aws_access_key_id $ACCESS_KEY
aws configure set default.aws_secret_access_key $SECRET_KEY
aws configure set default.region $REGION
#Deleting nodegroup
nodegroup=$(aws eks list-nodegroups --cluster-name prod --query 'nodegroups[0]')
temp="${nodegroup%\"}"
nodegroup="${temp#\"}"
aws eks delete-nodegroup --nodegroup-name $nodegroup --cluster-name prod
echo "Deleting Managed NodeGroup ..."
sleep 50
while [ $nodegroup != null ]
do
  nodegroup=$(aws eks list-nodegroups --cluster-name prod --query 'nodegroups[0]')
  sleep 5
done
echo "Managed Managed NodeGroup deleted successfully"
aws cloudformation delete-stack --stack-name All-in-One
echo "CloudFormation stack deleted successfully"
