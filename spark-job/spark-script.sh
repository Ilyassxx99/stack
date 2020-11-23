#!/bin/bash
#Getting Cluster URL
clusterurl=$(kubectl config view -o jsonpath='{.clusters[0].cluster.server}')
echo "Starting the spark job on the cluster $clusterurl ..."
#To launch Spark job using spark-submit
cd /opt/spark
bin/spark-submit \
--master k8s://$clusterurl \
--deploy-mode cluster \
--name spark-pi \
--class org.apache.spark.examples.SparkPi \
--conf spark.executor.instances=3 \
--conf spark.executor.memory=600m \
--conf spark.driver.memory=600m \
--conf spark.kubernetes.driver.request.cores=1 \
--conf spark.kubernetes.executor.request.cores=1 \
--conf spark.kubernetes.container.image=ilyassifez/bdataproject:sparky \
--conf spark.kubernetes.container.image.pullPolicy=IfNotPresent \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
local:///opt/spark/examples/jars/spark-examples_2.12-3.1.0-SNAPSHOT.jar 10000000
#Cleanup of spark job pods
# kubectl delete pods --all -n default
