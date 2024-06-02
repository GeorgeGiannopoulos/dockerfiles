#!/bin/bash

export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive
minimal_apt_get_install='apt-get install -y --no-install-recommends'

## Temporarily disable dpkg fsync to make building faster.
if [[ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]]; then
	echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup
fi

## Prevent initramfs updates from trying to run grub and lilo.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
export INITRD=no
mkdir -p /etc/container_environment
echo -n no > /etc/container_environment/INITRD

## Enable Ubuntu Universe and Multiverse.
sed -i 's/^#\s*\(deb .*universe\)$/\1/g' /etc/apt/sources.list
sed -i 's/^#\s*\(deb .*multiverse\)$/\1/g' /etc/apt/sources.list
apt-get update

## Upgrade all packages.
apt-get dist-upgrade -y --no-install-recommends

## Install HTTPS support for APT.
$minimal_apt_get_install apt-utils apt-transport-https ca-certificates language-pack-en gnupg2

## Fix locale.
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
echo -n en_US.UTF-8 > /etc/container_environment/LANG
echo -n en_US.UTF-8 > /etc/container_environment/LC_CTYPE
echo -n en_US:en > /etc/container_environment/LANGUAGE
echo -n en_US.UTF-8 > /etc/container_environment/LC_ALL

## Often used tools.
$minimal_apt_get_install curl less nano psmisc wget sudo

# fix other small problem.
rm /bin/sh
ln -s /bin/bash /bin/sh
echo `. /etc/lsb-release; echo ${DISTRIB_CODENAME/*, /}` >> /etc/container_environment/DISTRIB_CODENAME

#cleanup
apt-get clean
rm -rf /build
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
