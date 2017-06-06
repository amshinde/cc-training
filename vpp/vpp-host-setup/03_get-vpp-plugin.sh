sudo apt-get install golang-go
export GOPATH=/home/user/go
mkdir -p $GOPATH
go get github.com/clearcontainers/vpp

sudo mkdir -p /etc/docker/plugins

sudo cp $GOPATH/src/github.com/clearcontainers/vpp/vpp.json /etc/docker/plugins

sudo $GOPATH/bin/vpp &

sudo systemctl daemon-reload
sudo systemctl restart docker
