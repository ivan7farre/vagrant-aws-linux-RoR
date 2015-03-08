#!/bin/bash

set -e -x

# Needed so that the aptitude/apt-get operations will not be interactive
export DEBIAN_FRONTEND=noninteractive

cd /tmp
wget -q http://apt.puppetlabs.com/puppetlabs-release-wheezy.deb
sleep 3
dpkg -i puppetlabs-release-wheezy.deb
#sleep 20
#apt-get update && apt-get -y upgrade 
#sleep 10
#apt-get install -y puppet 

