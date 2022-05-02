#!/bin/bash
export USER=root
chmod +x /sshs
nohup /sshs 0.0.0.0 2222 &
echo 'PS1='"'"'${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;35;35m\]\w\[\033[00m\]\$\033[1;32;32m\] '"'" >> /root/.bashrc
mkdir -p /frp
cd /frp
wget https://github.com/fatedier/frp/releases/download/v0.42.0/frp_0.42.0_linux_amd64.tar.gz
tar -zxvf frp_0.42.0_linux_amd64.tar.gz
cd frp_0.42.0_linux_amd64
cp -f /frpc.ini .
nohup ./frpc -c ./frpc.ini &
chmod +x /getpubip
 /getpubip
