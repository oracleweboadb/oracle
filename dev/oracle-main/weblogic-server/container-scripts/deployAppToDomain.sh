#!/bin/bash
#
#Copyright (c) 2014-2018 Oracle and/or its affiliates. All rights reserved.
#
#Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

export ORDS_HOME=$DOMAIN_HOME

echo "db.hostname=$CUSTOM_DB_HOSTNAME" >> $ORDS_HOME/params/ords_params.properties
echo "db.port=$DB_PORT" >> $CUSTOM_ORDS_HOME/params/ords_params.properties
echo "db.servicename=$CUSTOM_DB_SERVICENAME" >> $ORDS_HOME/params/ords_params.properties
echo "user.public.password=$CUSTOM_USER_PUBLIC_PASSWORD" >> $ORDS_HOME/params/ords_params.properties
echo "sys.user=$CUSTOM_SYS_USER" >> $ORDS_HOME/params/ords_params.properties

echo $CUSTOM_SYS_PASSWORD > pass.txt
java -jar $ORDS_HOME/ords.war install --db-hostname $CUSTOM_DB_HOSTNAME --db-port $CUSTOM_DB_PORT --db-servicename $CUSTOM_DB_SERVICENAME  --admin-user 'SYS as DBA' --password-stdin < pass.txt

#Define DOMAIN_HOME
echo "Domain Home is: " $DOMAIN_HOME

# Deploy Application
wlst.sh -skipWLSModuleScanning /u01/oracle/app-deploy.py