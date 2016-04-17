FROM ubuntu:14.04

USER root

# install dev tools
RUN apt-get clean all; \
    apt-get install -y rpm; \
    rpm --rebuilddb; \
    apt-get install -y curl tar wget sudo openssh-server openssh-clients rsync vim ssh

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

# Set UTF-8 locale
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale

# Add files.
ADD .bashrc /root/.bashrc

# Install Java 8
RUN cd opt && wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u72-b15/jdk-8u72-linux-x64.tar.gz" &&\
   tar xzf jdk-8u72-linux-x64.tar.gz && rm -rf jdk-8u72-linux-x64.tar.gz

ENV JAVA_HOME /opt/jdk1.8.0_72
ENV PATH $PATH:/opt/jdk1.8.0_72/bin:/opt/jdk1.8.0_72/jre/bin:/etc/alternatives:/var/lib/dpkg/alternatives

RUN echo 'export JAVA_HOME="/opt/jdk1.8.0_72"' >> ~/.bashrc && \
    echo 'export PATH="$PATH:/opt/jdk1.8.0_72/bin:/opt/jdk1.8.0_72/jre/bin"' >> ~/.bashrc && \
    bash ~/.bashrc && cd /opt/jdk1.8.0_72/ && update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_72/bin/java 1

# passwordless ssh
RUN rm -f /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_rsa_key /root/.ssh/id_rsa
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# Install Hadoop 2.7.1
RUN cd /opt && wget https://www.apache.org/dist/hadoop/core/hadoop-2.7.1/hadoop-2.7.1.tar.gz && \
    tar xzvf hadoop-2.7.1.tar.gz && rm ./hadoop-2.7.1.tar.gz &&  mv hadoop-2.7.1/ hadoop

ENV HADOOP_HOME /opt/hadoop

ADD core-site.xml /opt/hadoop/etc/hadoop

ADD hdfs-site.xml /opt/hadoop/etc/hadoop

ADD mapred-site.xml /opt/hadoop/etc/hadoop

ADD yarn-site.xml /opt/hadoop/etc/hadoop

ADD hadoop-env.sh /opt/hadoop/etc/hadoop

CMD ["/bin/bash"]





