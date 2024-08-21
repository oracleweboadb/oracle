#!/bin/bash
#
#Copyright (c) 2014-2018 Oracle and/or its affiliates. All rights reserved.
#
#Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

CURRENT_DIR=$(pwd)

cd ${ORDS_HOME}

echo $CUSTOM_SYS_PASSWORD > pass.txt
echo $CUSTOM_SYS_PASSWORD >> pass.txt
echo $CUSTOM_SYS_PASSWORD >> pass.txt

java -jar $ORDS_HOME/ords.war install adb --wallet tls_wallet.zip --wallet-service-name myatp_medium --db-user ORDS_PUBLIC_USER2 --gateway-user ORDS_PLSQL_GATEWAY2 --admin-user admin --password-stdin < pass.txt
java -jar $ORDS_HOME/ords.war --config $(pwd) war ords.war

cd ${CURRENT_DIR}

#Define DOMAIN_HOME
echo "Domain Home is: " $DOMAIN_HOME

# Deploy Application
wlst.sh -skipWLSModuleScanning /u01/oracle/app-deploy.py