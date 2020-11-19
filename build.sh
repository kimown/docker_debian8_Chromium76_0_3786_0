#!/bin/bash

set -e
env
echo 'build.sh execute'
echo $(nproc)

#https://developer.aliyun.com/mirror/debian
cat <<\EOT> /etc/apt/sources.list
deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib
deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib
EOT

apt-get update && apt-get -y install build-essential vim wget git

cd /opt/tiger/mdk/

