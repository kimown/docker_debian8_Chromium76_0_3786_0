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


#https://unix.stackexchange.com/questions/2544/how-to-work-around-release-file-expired-problem-on-a-local-mirror
echo "Acquire::Check-Valid-Until false;" | tee -a /etc/apt/apt.conf.d/10-nocheckvalid
apt-get -o Acquire::Check-Valid-Until=false update
apt-get update && apt-get -y install build-essential vim wget git python lsb-release sudo





# jdk1.8
mkdir -p /opt/tiger/mdk/
cd /opt/tiger/mdk/
#https://gist.github.com/hgomez/9650687#gistcomment-3496315
#http://planetone.online/downloads/java/
wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" https://javadl.oracle.com/webapps/download/GetFile/1.8.0_271-b09/61ae65e088624f5aaa0b1d2d801acb16/linux-i586/jdk-8u271-linux-x64.tar.gz
tar -xzvf jdk-8u271-linux-x64.tar.gz 
export PATH="$PWD/jdk1.8.0_271/bin:$PATH"
echo "export PATH=$PWD/jdk1.8.0_271/bin:$PATH" >>~/.bashrc
java -version


# download chromium
cd /opt/tiger/mdk/
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH="$PATH:$PWD/depot_tools"
echo "export PATH=$PWD/depot_tools:$PATH" >>~/.bashrc
source ~/.bashrc
mkdir chromium && cd chromium
fetch --nohooks chromium
cd $DIR/chromium/src
git checkout -b chromium76_0_3786_0 tags/76.0.3786.0
git checkout chromium76_0_3786_0

gclient sync --with_branch_heads --with_tags

./build/install-build-deps.sh --no-arm
gclient runhooks


#https://unix.stackexchange.com/questions/429518/how-do-i-build-a-chromium-dist-preferably-zip-for-linix

gn gen out/Release --args="is_component_build=false is_debug=false symbol_level=0 enable_nacl=true blink_symbol_level=0 enable_linux_installer=true"
ninja -C out/Release chrome
ninja -C out/Release "chrome/installer/linux:unstable_deb"
ls out/Release/chromium-browser-unstable_76.0.3786.0-1_amd64.deb

#https://groups.google.com/a/chromium.org/g/chromium-dev/c/ZoJbiIxHf0o/m/AvIkPyxYBgAJ
#gn gen out/Default --args="is_official_build=true"
#python tools/mb/mb.py gen out/Default chrome chrome.zip