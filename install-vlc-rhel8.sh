#!/bin/bash

if ! grep -q "Red Hat Enterprise Linux release 8." /etc/redhat-release; then
    echo "This script is only designed for RHEL 8." >&2
    exit 1
fi

cat <<EOM
================================================
|               WARNING                        |
================================================

VLC can only be installed from RPMFusion.

This script will install the RPMFusion and EPEL
repos (if they are not already) and then disable
the RPMFusion repos by default. VLC and its
dependencies will then be installed.

If you are NOT OK with this: Ctrl+C
If you are all meh about this: Enter

EOM
read


echo "Setting up RPMFusion repo"
sleep 2
sudo dnf install -y https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm

echo "Disabling RPMFusion"
sleep 2
sudo sed 's/enabled=1/enabled=0/g' /etc/yum.repos.d/rpmfusion-free-updates.repo -i.bkp

echo "Installing VLC"
sleep 2
sudo dnf install --enablerepo rpmfusion-free-updates -y vlc

