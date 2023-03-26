#!/bin/bash

if [ "$(sudo docker ps -aq -f name=kail)" ]; then
    sudo docker rm -f kail
fi

cd config
for file in *.ovpn; do
    if [ "$file" != "groot_security_config.ovpn" ]; then
        mv "$file" "groot_security_config.ovpn"
    fi
done
cd ..

sudo docker build --network host -t kail_linux:0.0 `pwd`
sudo docker run --name kail --privileged --security-opt seccomp=unconfined --net host -i -t kail_linux:0.0
