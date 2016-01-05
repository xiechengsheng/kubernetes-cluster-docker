#!/bin/bash

echo -e "\nBuild kiwenlau/kubernetes-cluster:1.0.7 image"
sudo docker build -t kiwenlau/kubernetes-cluster:1.0.7 .

docker rm -f kubernetes-master kubernetes-slave > /dev/null

echo -e "\n\nRun kubernetes-master container"
docker run -it -d --name=kubernetes-master kiwenlau/kubernetes-cluster:1.0.7 /usr/bin/supervisord --configuration=/etc/supervisor/conf.d/kubernetes-master.conf 

echo -e "\n\nRun kubernetes-slave container"
docker run -it -d --link kubernetes-master:kubernetes-master --privileged  -v /var/run/docker.sock:/var/run/docker.sock --name=kubernetes-slave kiwenlau/kubernetes-cluster:1.0.7 /usr/bin/supervisord --configuration=/etc/supervisor/conf.d/kubernetes-slave.conf 