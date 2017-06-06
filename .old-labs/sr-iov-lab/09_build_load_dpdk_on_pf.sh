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

export PCI_PORT_0="00:0b.0"
export PCI_PORT_1="00:0c.0"
export TESTPMD_PF_IF="ens11"
export PKTGEN_PF_IF="ens12"
export TESTPMD_PF_MAC=$(ip l show ${TESTPMD_PF_IF} | grep ether | awk '{ print $2 }')
export PKTGEN_PF_MAC=$(ip l show ${PKTGEN_PF_IF} | grep ether | awk '{ print $2 }')
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
echo "PKTGEN_MAC=$PKTGEN_PF_MAC"
echo "TESTPMD_MAC=$TESTPMD_PF_MAC"
echo "******Keep these for the next step*****"

