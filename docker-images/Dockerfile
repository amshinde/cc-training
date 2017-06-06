#
# Network testing container, including DPDK testpmd
#

MAINTAINER Eric Ernst "eric.ernst@intel.com"

FROM ubuntu:16.04

ARG DPDK_VER=17.02
ARG DPDK_TARGET=x86_64-native-linuxapp-gcc

RUN apt-get update && apt-get -y install \
  apache2-utils \
  apt-transport-https \
  build-essential \
  git \
  ifupdown \
  iputils-ping \
  iperf \
  linux-headers-`uname -r` \
  lshw \
  net-tools \
  nginx \
  python \
  pciutils \
  sudo \
  tcpdump \
  vim

RUN git clone https://git.fd.io/vpp \
 && cd vpp \
 && git checkout stable/1701 \
 && make UNATTENDED=yes install-dep \
 && make build-release \
 && make pkg-deb \
 && cd build-root \
 && dpkg -i *.deb

#RUN echo "deb [trusted=yes] https://nexus.fd.io/content/repositories/fd.io.stable.1701.ubuntu.xenial.main/ ./" | tee -a /etc/apt/sources.list.d/99fd.io.list
#RUN apt-get update && apt-get -y install \
#  vpp \
#  vpp-dpdk-dkms

ADD http://fast.dpdk.org/rel/dpdk-${DPDK_VER}.tar.xz /opt
ADD setup-networking.sh /opt
WORKDIR /opt
RUN tar -xf dpdk-${DPDK_VER}.tar.xz && mv dpdk-${DPDK_VER} dpdk && cd dpdk && \
    sed -ri 's,(IGB_UIO=).*,\1n,' config/common_linuxapp && \
    sed -ri 's,(KNI_KMOD=).*,\1n,' config/common_linuxapp && \
    make config T=${DPDK_TARGET} && make -j && mkdir /mnt/huge
