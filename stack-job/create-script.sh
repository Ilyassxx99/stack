#!/bin/bash
#Set AWS credentials
aws configure set default.aws_access_key_id $ACCESS_KEY
aws configure set default.aws_secret_access_key $SECRET_KEY
aws configure set default.region $REGION
#CloudFormation Stack creation
aws cloudformation create-stack --stack-name All-in-One --template-body file://one-formation.yaml --capabilities CAPABILITY_NAMED_IAM
#Check if cluster created
echo "Creating CloudFormation Stack ..."
sleep 800
nodegroup=$(aws eks list-nodegroups --cluster-name prod --query 'nodegroups[0]')
temp="${nodegroup%\"}"
nodegroup="${temp#\"}"
echo "Creating EKS Cluster ..."
while [ $nodegroup == null ]
do
  nodegroup=$(aws eks list-nodegroups --cluster-name prod --query 'nodegroups[0]')
  sleep 5
done
echo "EKS cluster created successfully"
#AWS user authentication to cluster
aws eks update-kubeconfig --name prod
echo "Waiting for Cluster nodes initiation ..."
sleep 300
#Listing Cluster nodes
kubectl get nodes
#Creating service account to be used by spark job
kubectl create serviceaccount spark
kubectl create clusterrolebinding spark-role --clusterrole=edit  --serviceaccount=default:spark --namespace=default
echo "Deploying kube-opex-analytics ..."
kubectl apply -f k8s
sleep 10
podname=$(kubectl get pods -o jsonpath='{.items[0].metadata.name}')
kubectl port-forward $podname 5483:5483
