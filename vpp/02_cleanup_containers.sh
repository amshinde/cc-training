sudo docker kill `sudo docker ps --no-trunc -aq` ; sudo docker rm `sudo docker ps --no-trunc -aq`
sudo docker network rm vpp_net
sudo service vpp stop
sudo service vpp start
