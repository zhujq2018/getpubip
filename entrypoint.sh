#!/bin/bash
export USER=root
chmod +x /sshs
触摸到+x /server
nohup /sshs 0.0.0.0 2222 &
nohup /server  &
echo 'PS1='"'"'${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;35;35m\]\w\[\033[00m\]\$\033[1;32;32m\] '"'" >> /root/.bashrc

mkdir -p /root/tail
cd /root/tail
cp /ts.tgz .
tar xzf ts.tgz --strip-components=1
mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale
nohup ./tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
./tailscale up --authkey=${TAILSCALE_AUTHKEY} --hostname=render-vps

chmod +x /getpubip
 /getpubip
