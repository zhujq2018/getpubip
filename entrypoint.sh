#!/bin/bash
export USER=root
mv /authorized_keys /root/.ssh/authorized_keys
mv /id_rsa /root/.ssh/id_rsa
mv /id_rsa.pub /root/.ssh/id_rsa.pub
chmod 600 /root/.ssh/id_rsa
chmod 644 /root/.ssh/id_rsa.pub
chmod 600 /root/.ssh/authorized_keys
echo 'PS1='"'"'${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;35;35m\]\w\[\033[00m\]\$\033[1;32;32m\] '"'" >> /root/.bashrc
mkdir -p /var/run/sshd
nohup /usr/sbin/sshd -D &
mkdir -p /frp
cd /frp
wget https://github.com/fatedier/frp/releases/download/v0.42.0/frp_0.42.0_linux_amd64.tar.gz
tar -zxvf frp_0.42.0_linux_amd64.tar.gz
cd frp_0.42.0_linux_amd64

chmod +x ./getpubip
 ./getpubip
