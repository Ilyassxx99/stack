#!/bin/bash
#Set AWS credentials
aws configure set default.aws_access_key_id $ACCESS_KEY
aws configure set default.aws_secret_access_key $SECRET_KEY
aws configure set default.region $REGION
#CloudFormation Stack creation
aws cloudformation create-stack --stack-name All-in-One --template-body file://one-formation.yaml --capabilities CAPABILITY_NAMED_IAM
#Check if cluster created
echo "Creating CloudFormation Stack ..."
sleep 600
stackstatus=$(aws cloudformation describe-stacks --stack-name All-in-One --query 'Stacks[0].StackStatus')
temp="${stackstatus%\"}"
stackstatus="${temp#\"}"
condition="CREATE_COMPLETE"
while [ "$stackstatus" != "$condition" ]
do
  stackstatus=$(aws cloudformation describe-stacks --stack-name All-in-One --query 'Stacks[0].StackStatus')
  temp="${stackstatus%\"}"
  stackstatus="${temp#\"}"
  sleep 5
done
echo "CloudFormation Stack created successfully"
#AWS user authentication to cluster
aws eks update-kubeconfig --name prod
#Listing Cluster nodes
kubectl get nodes
#Creating service account to be used by spark job
kubectl create serviceaccount spark
kubectl create clusterrolebinding spark-role --clusterrole=edit  --serviceaccount=default:spark --namespace=default
kubectl apply -f k8s
echo "Deploying kube-opex-analytics ..."
sleep 40
podname=$(kubectl get pods -o jsonpath='{.items[0].metadata.name}')
kubectl port-forward $podname 5483:5483
