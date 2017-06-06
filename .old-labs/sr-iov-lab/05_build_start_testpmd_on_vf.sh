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

if [ "$1" == "" ]; then
        echo "Usage: $@ <MAC Address for pktgen ethernet port>"
        exit 1
fi

#-i -- interactive mode
#--burst=64 -- we are going to fetch 64 packets at at time
#--txd=2048/--rxd=2048 -- we want 2048 descriptors in the rx and tx rings
#--port-topology=chained -- we only have one port, so it has to do rx and tx
TESTPMD_PARAMS="--burst=64 -i --txd=2048 --rxd=2048 --port-topology=chained --eth-peer=0,$1 --forward-mode=macswap --auto-start --crc-strip"

#-c 0x08 -- DPDK can run on cpu: 0000 1000
#-n 1 we only have one memory bank in this VM
#--pci-whitelist -- DPDK will only use the device at this PCI address
DPDK_PARAMS="-c 0x06 -l 3,4 -n 1 --socket-mem 512 --file-prefix testpmd --pci-whitelist 00:09.0"

#make sure that DPDK has been built
cd $RTE_SDK
make config O=$RTE_TARGET T=$RTE_TARGET
cd $RTE_TARGET
make -j10

#build testpmd
cd $RTE_SDK/app/test-pmd
make -j10

$RTE_SDK/app/test-pmd/testpmd $DPDK_PARAMS -- $TESTPMD_PARAMS
