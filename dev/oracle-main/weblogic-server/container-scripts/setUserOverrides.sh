#!/bin/bash

if [ "${SERVER_NAME}" = "AdminServer" ]; then
    export USER_MEM_ARGS="-Xms1g -Xmx2g"
fi

if [ "${SERVER_NAME}" = "WLS_ORDS1" ]; then
    export USER_MEM_ARGS="-Xms2g -Xmx6g"
fi

if [ "${SERVER_NAME}" = "WLS_ORDS2" ]; then
    export USER_MEM_ARGS="-Xms2g -Xmx6g"
fi