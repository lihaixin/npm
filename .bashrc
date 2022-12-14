#!/bin/bash

if [ -t 1 ]; then
	export PS1="\e[1;34m[\e[1;33m\u@\e[1;32mdocker-\h\e[1;37m:\w\[\e[1;34m]\e[1;36m\\$ \e[0m"
fi

# Aliases
alias l='ls -lAsh --color'
alias ls='ls -C1 --color'
alias cp='cp -ip'
alias rm='rm -i'
alias mv='mv -i'
alias h='cd ~;clear;'
alias reboot='pkill -s 1;sleep 1;pkill -s 1'

: ${MainINF:=$(ip route | grep "default via" |awk '{ print $5}')}
: ${MainIP:=$(/sbin/ifconfig $MainINF | grep 'inet ' | awk '{ print $2}')}
IP=$(curl -s  ip.sb)

. /etc/os-release

echo -e -n '\E[1;34m'
figlet -k -f big -c -m-1 -w 120 "Welcome `hostname`"
echo " # ---------------------------------------------------------------------------------------------------------------- #"
if [ -f "/etc/member" ]; then
MEMBER=`cat /etc/member`
if [ "$MEMBER" == "0" ]; then
echo " # `cat /etc/npsnotice` "
else
echo " # 容器ID： `cat /etc/dockerid` "
fi
fi
echo -e "\E[1;36m # Version \E[1;32m${NPM_BUILD_VERSION:-2.0.0-dev} (${NPM_BUILD_COMMIT:-dev}) ${NPM_BUILD_DATE:-0000-00-00}\E[1;36m, OpenResty \E[1;32m${OPENRESTY_VERSION:-unknown}\E[1;36m, ${ID:-debian} \E[1;32m${VERSION:-unknown}\E[1;36m, Certbot \E[1;32m$(certbot --version)\E[0m"
echo -e -n '\E[1;34m'
echo " # Nginx(外网IP)管理地址: http://$IP:81   默认管理员用户：Email: admin@example.com Password: changeme "
echo " # Nginx(内网IP)管理地址: http://$MainIP:81   默认管理员用户：Email: admin@example.com Password: changeme "
# cat /built-for-arch
echo " # 更多信息访问网页查看： https://hub.docker.com/r/lihaixin/npm "
echo " # ---------------------------------------------------------------------------------------------------------------- #"
if [ -f "/etc/member" ]; then
QQ=`cat /etc/envfile | grep QQ | awk -F "=" '{ print $2}'`
echo " # "
echo " # 技术支持QQ:         $QQ"
fi
echo -e '\E[0m'
