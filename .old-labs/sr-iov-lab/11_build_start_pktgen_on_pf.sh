#!/bin/bash

if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

if [ "$RTE_SDK" == "" ]; then
	echo "Sorry, RTE_SDK env var has not been set to root of DPDK src tree"
	exit 1
fi

if [ "$RTE_TARGET" == "" ]; then
	echo "Sorry, RTE_TARGET env var has not been set to DPDK target build env"
	exit 1
fi

#In these parameters, we lock pktgen to do 
#	port 0 rx on core 1
#	port 0 tx on core 2

#[1:2].0 -- on port 0, core 1 does rx, core 2 does tx
PKTGEN_PARAMS='-T -p 0x3 -P -m "[1:2].0"'
#-c 0x6 -- DPDK can run on cpus: 0000 0110
#-n 1 we only have one memory bank in this VM
#--pci-whitelist -- DPDK will only use the device at PCI address
DPDK_PARAMS="-c 0x06 -n 1 --proc-type auto --socket-mem 512 --file-prefix pg --pci-whitelist 00:0c.0"

#make sure that DPDK has been built
cd $RTE_SDK
make config O=$RTE_TARGET T=$RTE_TARGET
cd $RTE_TARGET
make -j10

export PKTGEN_DIR=/usr/src/pktgen-3.0.14
cd $PKTGEN_DIR
make -j10


./app/app/$RTE_TARGET/pktgen $DPDK_PARAMS -- $PKTGEN_PARAMS 

