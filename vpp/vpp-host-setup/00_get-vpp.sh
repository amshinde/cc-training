sudo rm /etc/apt/sources.list.d/99fd.io.list
echo "deb [trusted=yes] https://nexus.fd.io/content/repositories/fd.io.ubuntu.xenial.main/ ./" | sudo tee -a /etc/apt/sources.list.d/99fd.io.list
sudo -E apt-get update
sudo -E apt-get install vpp vpp-dpdk-dkms vpp-plugins
