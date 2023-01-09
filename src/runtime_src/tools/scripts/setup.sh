#!/bin/bash
# Script to setup environment for XRT
# This script is installed in /opt/xilinx/xrt and must
# be sourced from that location

# Check OS version requirement
OSDIST=`cat /etc/os-release | grep -i "^ID=" | awk -F= '{print $2}'`
OSREL=`cat /etc/os-release | grep -i "^VERSION_ID=" | awk -F= '{print $2}' | tr -d '".'`

if [[ $OSDIST == "ubuntu" ]]; then
    if (( $OSREL < 1604 )); then
        echo "ERROR: Ubuntu release version must be 16.04 or later"
        return 1
    fi
fi

if [[ $OSDIST == "centos" ]] || [[ $OSDIST == "rhel"* ]]; then
    if (( $OSREL < 704 )); then
        echo "ERROR: Centos or RHEL release version must be 7.4 or later"
        return 1
    fi
fi

XILINX_XRT=$(readlink -f $(dirname ${BASH_SOURCE[0]}))

if [[ $XILINX_XRT != *"/opt/xilinx/xrt" ]]; then
    echo "Invalid location: $XILINX_XRT"
    echo "This script must be sourced from XRT install directory"
    return 1
fi

# To use the newest version of the XRT tools, either uncomment or set 
# the following environment variable in your profile:
#   export XRT_TOOLS_NEXTGEN=true

export XILINX_XRT
export LD_LIBRARY_PATH=$XILINX_XRT/lib:$LD_LIBRARY_PATH
export PATH=$XILINX_XRT/bin:$PATH
export PYTHONPATH=$XILINX_XRT/python:$PYTHONPATH

echo "XILINX_XRT        : $XILINX_XRT"
echo "PATH              : $PATH"
echo "LD_LIBRARY_PATH   : $LD_LIBRARY_PATH"
echo "PYTHONPATH        : $PYTHONPATH"
