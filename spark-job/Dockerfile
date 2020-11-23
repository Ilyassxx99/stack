# base image
FROM ubuntu:latest

# define spark and hadoop versions
ENV SPARK_VERSION=3.0.0
ENV HADOOP_VERSION=3.3.0

# update repositories
RUN apt-get update
RUN apt-get install -y curl

# download and install java
RUN apt-get install -y openjdk-8-jdk
RUN export JAVA_HOME=$(readlink -f $(which java))

# download and install netcat
RUN apt-get install -y netcat

# download and install hadoop
RUN mkdir -p /opt && \
    cd /opt && \
    curl http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | \
        tar -zx hadoop-${HADOOP_VERSION}/lib/native && \
    ln -s hadoop-${HADOOP_VERSION} hadoop && \
    echo Hadoop ${HADOOP_VERSION} native libraries installed in /opt/hadoop/lib/native

# download and install spark
RUN mkdir -p /opt && \
    cd /opt && \
    curl http://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz | \
        tar -zx && \
    ln -s spark-${SPARK_VERSION}-bin-hadoop2.7 spark && \
    echo Spark ${SPARK_VERSION} installed in /opt

# download and install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# add scripts and update spark default config
RUN mkdir /scripts
COPY spark-script.sh /scripts
RUN cd /scripts && chmod +x spark-script.sh
ENV PATH $PATH:/opt/spark/bin
WORKDIR /scripts
