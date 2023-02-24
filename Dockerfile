FROM centos:7
MAINTAINER Serfim TIC

# Base NPM
RUN yum -y update && yum -y groupinstall "Development Tools"

RUN yum install -y \
  glibc-langpack\
  libmpc-devel \
  mpfr-devel \
  gmp-devel \
  gcc \
  g++ \
  make \
  git \
  rpm \
  curl \
  wget \
  jq \
  python3 \
  util-linux \
  unzip

# GCC 9.3.1
RUN yum -y install centos-release-scl && yum -y install devtoolset-9
ENV PATH=/opt/rh/devtoolset-9/root/usr/bin/:$PATH
RUN echo "source /opt/rh/devtoolset-9/enable" >> /etc/bashrc
SHELL ["/bin/bash", "--login", "-c"]

ENV SONAR_SCANNER_VERSION 4.2.0.1873

RUN curl -sL https://rpm.nodesource.com/setup_16.x | bash - \
  && yum install -y nodejs

RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    cd /usr/bin && \
    ln -s /sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin/sonar-scanner sonar-scanner

RUN rm /sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip
