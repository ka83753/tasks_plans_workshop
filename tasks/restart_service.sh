#! /bin/bash

#
# Specify service to restart
#

#
# Check current service status
#
if ! systemctl is-active --quiet ${PT_service} ; then
    echo "Unable to get status of service ${PT_service}"
    exit 1
fi

systemctl restart ${PT_service}
