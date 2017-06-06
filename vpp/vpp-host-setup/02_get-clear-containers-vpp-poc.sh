## Standard Clear Containers 2.1 packages:
#sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/clearlinux:/preview:/clear-containers-2.1/xUbuntu_$(lsb_release -rs)/ /' >> /etc/apt/sources.list.d/cc-oci-runtime.list"
#curl -fsSL http://download.opensuse.org/repositories/home:clearlinux:preview:clear-containers-2.1/xUbuntu_$(lsb_release -rs)/Release.key | sudo apt-key add -

## example below is to grab a special build of Clear Containers 2.1 which supports VHost User interfaces:
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/egernst:/clear-containers-2.1-poc/xUbuntu_$(lsb_release -rs)/ /' >> /etc/apt/sources.list.d/cc-oci-runtime.list"
curl -fsSL http://download.opensuse.org/repositories/home:/egernst:/clear-containers-2.1-poc/xUbuntu_$(lsb_release -rs)/Release.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y cc-oci-runtime

## Configure Docker to use Clear Containers by default
sudo mkdir -p /etc/systemd/system/docker.service.d/
cat << EOF | sudo tee /etc/systemd/system/docker.service.d/clr-containers.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -D --add-runtime cor=/usr/bin/cc-oci-runtime --default-runtime=cor
EOF

## Restart Docker to take change into account:
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/clearlinux:/preview:/clear-containers-2.1/xUbuntu_$(lsb_release -rs)/ /' >> /etc/apt/sources.list.d/cc-oci-runtime.list"
curl -fsSL http://download.opensuse.org/repositories/home:clearlinux:preview:clear-containers-2.1/xUbuntu_$(lsb_release -rs)/Release.key | sudo apt-key add -

