#!/bin/bash

if [ "${HOSTNAME}" = "weblogic-admin" ]; then
    export USER_MEM_ARGS="-Xms1g -Xmx2g"
fi

if [ "${wls_ords1}" = "managed-server1" ]; then
    export USER_MEM_ARGS="-Xms2g -Xmx6g"
fi

if [ "${wls_ords2}" = "WLS_ORDS2" ]; then
    export USER_MEM_ARGS="-Xms2g -Xmx6g"
fi