#!/bin/sh
# See more file distros at http://linuxmafia.com/faq/Admin/release-files.html

if [ -r "/etc/lsb-release" ]; then
    echo "Detected 'lsb-release' (checking debian release...)"
    DISTRO_ID=$(grep 'DISTRIB_ID' /etc/lsb-release | sed 's/DISTRIB_ID=//')
    DISTRO_RELEASE=$(grep 'DISTRIB_RELEASE' /etc/lsb-release | sed 's/DISTRIB_RELEASE=//')
    DISTRO="$DISTRO_ID $DISTRO_RELEASE"
    echo "Distribution: $DISTRO"
    if [ "${DISTRO}" = "Ubuntu 14.04" ]; then
        echo "Distribution $DISTRO supported! upgrading..."
        export DEBIAN_FRONTEND=noninteractive
        apt-get -y update
        grep security /etc/apt/sources.list > /tmp/security.list
        apt-get upgrade -y -u -oDir::Etc::Sourcelist=/tmp/security.list
        RET=$?
        if [ $RET -eq 0 ]; then
            echo "Security upgrade finished"
        else
            echo "Security upgrade failed with error code $RET"
        fi
        rm /tmp/security.list
    else
        echo "Ubuntu distribution not supported."
    fi

elif [ -r "/etc/redhat-release" ]; then
    echo "Detected 'redhat-release' (checking redhat release...)"
    DISTRO="`cat /etc/centos-release | awk '{ print $1, $4 }' | cut -d '.' -f1`"
    echo "Distribution: $DISTRO"
    if [ "${DISTRO}" = "CentOS 7" ] || [ "${DISTRO}" = "Redhat 10" ]; then
        echo "Distribution $DISTRO supported! upgrading..."
        yum -y update --security
        RET=$?
        if [ $RET -eq 0 ]; then
            echo "Security upgrade finished"
        else
            echo "Security upgrade failed with error code $RET"
        fi
    else
        echo "RH distribution not supported."
    fi
fi
