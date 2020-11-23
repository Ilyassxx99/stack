# readme

This repository has a docker-compose files that let you create and delete EKS cluster with 5 t2.micro nodes autoscaled between 3 and 7. It contains a docker-compose to start spark job on the EKS cluster.
You should have docker and docker-compose installed in your environment


## Prepare the content

To successfully create the cluster, please enter your AWS user (with the right permissions to use AWS resources) Access_key and Secret_key and Region used, in the .env file in 
```
- stack-job/stack-creator
- stack-job/stack-destructor
```
## Running the containers

### Create EKS Cluster

To create the EKS cluster go to :
```
 stack-job/stack-creator
```
and execute :
```
 docker-compose up
```
### Delete EKS Cluster

To delete the EKS cluster go to :
```
 stack-job/stack-destructor
```
and execute :
```
 docker-compose up
```
### Run Spark job

To run a spark job go to :
```
 spark-job
```
and execute :
```
 docker-compose up
```
