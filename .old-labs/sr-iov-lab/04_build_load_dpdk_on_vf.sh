#!/bin/bash

if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

if [ "$RTE_SDK" == "" ]; then
	echo "Sorry, RTE_SDK has not been defined."
	exit 1
fi

if [ "$RTE_TARGET" == "" ]; then
	echo "Sorry, RTE_TARGET has not been defined."
	exit 1
fi

export PCI_PORT_0="00:09.0"
export PCI_PORT_1="00:0a.0"
export TESTPMD_VF_IF="ens9"
export PKTGEN_VF_IF="ens10"
export TESTPMD_VF_MAC=$(ip l show ${TESTPMD_VF_IF} | grep ether | awk '{ print $2 }')
export PKTGEN_VF_MAC=$(ip l show ${PKTGEN_VF_IF} | grep ether | awk '{ print $2 }')
cd $RTE_SDK
make config O=$RTE_TARGET T=$RTE_TARGET
cd $RTE_TARGET
make -j10

modprobe uio
insmod $RTE_SDK/$RTE_TARGET/kmod/igb_uio.ko

mount -t hugetlbfs nodev /mnt/huge

cat /proc/meminfo

echo "Binding $PCI_PORT_0 to igb_uio"
python $RTE_SDK/tools/dpdk-devbind.py --bind=igb_uio $PCI_PORT_0
echo "Binding $PCI_PORT_1 to igb_uio"
python $RTE_SDK/tools/dpdk-devbind.py --bind=igb_uio $PCI_PORT_1
python $RTE_SDK/tools/dpdk-devbind.py --status

echo "******Keep these for the next step*****"
echo "PKTGEN_MAC=$PKTGEN_VF_MAC"
echo "TESTPMD_MAC=$TESTPMD_VF_MAC"
echo "******Keep these for the next step*****"

