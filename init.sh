#!/bin/bash

if [ "$(sudo docker ps -aq -f name=kail)" ]; then
    sudo docker rm -f kail
fi

if [ -d "config" ] && [ -f "config/groot_security_config.ovpn" ]; then
  echo "config 디렉터리와 groot_security_config.ovpn 파일이 이미 존재합니다."
else
  if [ ! -d "config" ]; then
    mkdir config
  fi

  mv *.ovpn config/

  cd config
  for file in *.ovpn; do
      if [ "$file" != "groot_security_config.ovpn" ]; then
          mv "$file" "groot_security_config.ovpn"
      fi
  done
  cd ..
fi

sudo docker build --network host -t kail_linux:0.0 `pwd`
sudo docker run --name kail --privileged --security-opt seccomp=unconfined --net host -i -t kail_linux:0.0
