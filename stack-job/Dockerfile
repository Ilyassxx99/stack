FROM ubuntu:latest

# update repositories
RUN apt-get update
RUN apt-get install curl -y

# download and install python
RUN apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev && \
    curl -O https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tar.xz && \
    tar -xf Python-3.8.2.tar.xz && \
    cd Python-3.8.2 && \
    ./configure --enable-optimizations && \
    make -j 4 && \
    make altinstall

# download and install aws cli
RUN apt-get install -y unzip
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# download and install Kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

# add scripts and update spark default config
RUN mkdir -p /scripts/k8s
COPY create-script.sh  /scripts
COPY delete-script.sh  /scripts
COPY one-formation.yaml /scripts
COPY k8s /scripts/k8s
RUN cd /scripts && chmod +x create-script.sh
RUN cd /scripts && chmod +x delete-script.sh
ENV PATH $PATH:/opt/spark/bin
WORKDIR /scripts
