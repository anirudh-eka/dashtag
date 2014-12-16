#!/usr/bin/env bash
set -e
if [ "$EUID" -ne "0" ] ; then
  echo "Script must be run as root." >&2
  exit 1
fi

if which puppet > /dev/null ; then
  echo "Puppet is already installed"
else
  echo "Installing Puppet repo for Ubuntu 12.04 LTS"
  wget -qO /tmp/puppetlabs-release-precise.deb https://apt.puppetlabs.com/puppetlabs-release-precise.deb

  dpkg -i /tmp/puppetlabs-release-precise.deb
  rm /tmp/puppetlabs-release-precise.deb
  aptitude update
  echo Installing puppet
  aptitude install -y puppet
  echo "Puppet installed!"
fi

# ensure hiera is able to find our stuff
if [ ! -d "/etc/puppet" ]
then
 sudo echo "Y" | mkdir /etc/puppet
fi

echo "cd /vagrant" >> /home/vagrant/.bashrc
