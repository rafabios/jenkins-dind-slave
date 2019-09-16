FROM jenkins/slave

USER root

# Install docker
ENV DOCKER_VERSION 18.03.1-ce

RUN set -x \
  && curl -fSL "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
  && tar -xzvf docker.tgz \
  && mv docker/* /usr/local/bin/ \
  && rmdir docker \
  && rm docker.tgz \
  && docker -v

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && chmod +x ./kubectl \
  && mv ./kubectl /usr/local/bin/kubectl

# Install Terraform
RUN curl -LO https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip \
  && unzip terraform_0.11.7_linux_amd64.zip \
  && rm terraform_0.11.7_linux_amd64.zip \
  && chmod +x ./terraform \
  && mv terraform /usr/local/bin/terraform

# Install python tools
RUN apt-get update && apt-get install -y python-pip git python 

# Install gcloud SDK
#RUN curl -sSL https://sdk.cloud.google.com | bash
#RUN mv /home/jenkins/google-cloud-sdk /usr/local/google-cloud-sdk

# Install kube-automate tools 
RUN git clone https://spobvokd1001.indusval.com.br/root/templates-utils.git && \
  cd templates-utils && \
  /bin/bash setup.py 


# Configure runtime
COPY docker-entrypoint.sh /usr/local/bin/
#COPY jenkins-slave /usr/local/bin/jenkins-slave

RUN chmod +x /usr/local/bin/docker-entrypoint.sh
#RUN chmod +x /usr/local/bin/jenkins-slave

ENV PATH="/usr/local/google-cloud-sdk/bin:$PATH"
ENTRYPOINT docker-entrypoint.sh; jenkins-slave
