#!/bin/bash

set -e
env
echo 'build.sh execute'
echo $(nproc)

#http://mirrors.ustc.edu.cn/help/debian.html
#https://mirrors.huaweicloud.com/
#https://developer.aliyun.com/mirror/debian
#http://mirrors.163.com/.help/debian.html
cat <<\EOT> /etc/apt/sources.list
deb http://mirrors.163.com/debian/ jessie main non-free contrib
deb http://mirrors.163.com/debian-archive/debian/ jessie-backports main non-free contrib
deb-src http://mirrors.163.com/debian/ jessie main non-free contrib
deb-src http://mirrors.163.com/debian-archive/debian/ jessie-backports main non-free contrib
deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib
deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib
EOT


apt-get -o Acquire::Check-Valid-Until=false update

#https://unix.stackexchange.com/questions/2544/how-to-work-around-release-file-expired-problem-on-a-local-mirror
echo "Acquire::Check-Valid-Until false;" | tee -a /etc/apt/apt.conf.d/10-nocheckvalid



apt-get update && apt-get -y install build-essential vim wget git

cd /opt/tiger/mdk/

