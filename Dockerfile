FROM kalilinux/kali-rolling:latest

# 환경설정
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install kali-linux-headless kali-linux-large
RUN mkdir /home/deku /home/deku/vpn_config
RUN mkdir -p /dev/net && mknod /dev/net/tun c 10 200 && chmod 600 /dev/net/tun
COPY config /home/deku/vpn_config
WORKDIR /home/deku
CMD ["openvpn", "vpn_config/groot_security_config.ovpn"]
