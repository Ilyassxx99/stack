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
echo "Managed NodeGroup deleted successfully"
aws cloudformation delete-stack --stack-name All-in-One
echo "Deleting CloudFromation stack ..."
sleep 40
stackstatus=$(aws cloudformation describe-stacks --stack-name All-in-One --query 'Stacks[0].StackStatus')
temp="${stackstatus%\"}"
stackstatus="${temp#\"}"
condition="DELETE_IN_PROGRESS"
while [ "$stackstatus" == "$condition" ]
do
  stackstatus=$(aws cloudformation describe-stacks --stack-name All-in-One --query 'Stacks[0].StackStatus')
  temp="${stackstatus%\"}"
  stackstatus="${temp#\"}"
  sleep 5
done
echo "CloudFormation stack deleted successfully"
