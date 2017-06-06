lspci
echo 0000:00:05.0 > /sys/bus/pci/drivers/virtio-pci/unbind
echo 0000:00:04.0 > /sys/bus/pci/drivers/virtio-pci/unbind
./dpdk/usertools/dpdk-devbind.py --bind=uio_pci_generic 00:04.0
./dpdk/usertools/dpdk-devbind.py --bind=uio_pci_generic 00:05.0
./dpdk/usertools/dpdk-devbind.py --status
mount -t hugetlbfs none /mnt/huge
./dpdk/build/build/app/test-pmd/testpmd -- -i
