#Copyright (c) 2014, 2020, Oracle and/or its affiliates.
#
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
#
# ORACLE DOCKERFILES PROJECT
# --------------------------
# This Dockerfile extends the Oracle WebLogic image by creating a sample domain.
#
# Util scripts are copied into the image enabling users to plug NodeManager
# automatically into the AdminServer running on another container.
#
# HOW TO BUILD THIS IMAGE
# -----------------------
# Put all downloaded files in the same directory as this Dockerfile
# Run:
#      $ sudo docker build -t 12213-domain-home-image
#
# Pull base image test
# ---------------
FROM container-registry.oracle.com/middleware/weblogic:14.1.1.0-11

# Maintainer
# ----------
MAINTAINER Monica Riccelli <monica.riccelli@oracle.com>

ARG CUSTOM_DOMAIN_NAME="${CUSTOM_DOMAIN_NAME:-domain1}"
ARG CUSTOM_ADMIN_PORT="${CUSTOM_ADMIN_PORT:-7001}"  
ARG CUSTOM_ADMIN_SERVER_SSL_PORT="${CUSTOM_ADMIN_SERVER_SSL_PORT:-7002}"  
ARG CUSTOM_MANAGED_SERVER_PORT="${CUSTOM_MANAGED_SERVER_PORT:-8001}"
ARG CUSTOM_MANAGED_SERVER_SSL_PORT="${CUSTOM_MANAGED_SERVER_SSL_PORT:-8002}"
ARG CUSTOM_DEBUG_PORT="${CUSTOM_DEBUG_PORT:-8453}"
ARG CUSTOM_ADMIN_NAME="${CUSTOM_ADMIN_NAME:-admin-server}"
ARG CUSTOM_ADMIN_HOST="${CUSTOM_ADMIN_HOST:-wlsadmin}"
ARG CUSTOM_CLUSTER_NAME="${CUSTOM_CLUSTER_NAME:-DockerCluster}"
ARG CUSTOM_SSL_ENABLED="${CUSTOM_SSL_ENABLED:-false}"
ARG CUSTOM_DB_HOSTNAME="${CUSTOM_DB_HOSTNAME:-false}"
ARG CUSTOM_DB_PORT="${CUSTOM_DB_PORT:-false}"
ARG CUSTOM_DB_SERVICENAME="${CUSTOM_DB_SERVICENAME:-false}"
ARG CUSTOM_USER_PUBLIC_PASSWORD="${CUSTOM_USER_PUBLIC_PASSWORD:-false}"
ARG CUSTOM_SYS_USER="${CUSTOM_SYS_USER:-false}"
ARG CUSTOM_SYS_PASSWORD="${CUSTOM_SYS_PASSWORD:-false}"

# WLS Configuration
# ---------------------------
ENV ORACLE_HOME=/u01/oracle \
    PROPERTIES_FILE_DIR="/u01/oracle/properties" \
    SSL_ENABLED="${CUSTOM_SSL_ENABLED}" \
    DOMAIN_NAME="${CUSTOM_DOMAIN_NAME}" \
    DOMAIN_HOME="/u01/oracle/user_projects/domains/${CUSTOM_DOMAIN_NAME}" \
    ADMIN_PORT="${CUSTOM_ADMIN_PORT}" \
    ADMIN_SERVER_SSL_PORT="${CUSTOM_ADMIN_SERVER_SSL_PORT}" \
    ADMIN_NAME="${CUSTOM_ADMIN_NAME}" \
    ADMIN_HOST="${CUSTOM_ADMIN_HOST}" \
    CLUSTER_NAME="${CUSTOM_CLUSTER_NAME}" \
    MANAGED_SERVER_PORT="${CUSTOM_MANAGED_SERVER_PORT}" \
    MANAGED_SERVER_SSL_PORT="${CUSTOM_MANAGED_SERVER_SSL_PORT}" \
    MANAGED_SERV_NAME="${CUSTOM_MANAGED_SERV_NAME}" \
    DEBUG_PORT="8453" \
    PATH=$PATH:/u01/oracle/oracle_common/common/bin:/u01/oracle/wlserver/common/bin:${DOMAIN_HOME}:${DOMAIN_HOME}/bin:/u01/oracle

# Add files required to build this image
COPY --chown=oracle:root container-scripts/* /u01/oracle/

#Create directory where domain will be written to
USER root

ENV ORDS_HOME="/u01/oracle/user_projects/ords"

RUN chmod +xw /u01/oracle/*.sh && \
    chmod +xw /u01/oracle/*.py && \
    mkdir -p ${PROPERTIES_FILE_DIR} && \
    mkdir -p $DOMAIN_HOME && \
    chown -R oracle:root $DOMAIN_HOME/.. && \
    chown -R oracle:root ${PROPERTIES_FILE_DIR} && \
    mkdir $ORDS_HOME && \
    mkdir $ORDS_HOME/conf && \
    mkdir $ORDS_HOME/params && \
    chown -R oracle:root $ORDS_HOME

COPY --chown=oracle:root resources/ords.war $ORDS_HOME/ords.war
COPY --chown=oracle:root resources/tls_wallet.zip $ORDS_HOME/tls_wallet.zip
COPY --chown=oracle:root container-scripts/deployAppToDomain.sh $ORDS_HOME/
COPY --chown=oracle:root container-scripts/app-deploy.py $ORDS_HOME/
COPY --chown=oracle:root properties/docker-build/ords_params.properties $ORDS_HOME/params/

RUN chmod +xw $ORDS_HOME/*.sh && \
    chmod +xw $ORDS_HOME/*.py

COPY --chown=oracle:root properties/docker-build/domain*.properties ${PROPERTIES_FILE_DIR}/

# Configuration of WLS Domain
USER oracle

RUN /u01/oracle/createWLSDomain.sh && \
    chmod -R g+w $DOMAIN_HOME && \
    echo ". $DOMAIN_HOME/bin/setDomainEnv.sh" >> /u01/oracle/.bashrc && \
    rm ${PROPERTIES_FILE_DIR}/*.properties

COPY container-scripts/setUserOverrides.sh $DOMAIN_HOME/bin/setUserOverrides.sh

#RUN chmod -R g+w $ORDS_HOME && \
#    $ORDS_HOME/deployAppToDomain.sh

COPY properties/docker-build/ords_settings.xml $ORDS_HOME/global/settings.xml

# Expose ports for admin, managed server, and debug
EXPOSE $ADMIN_PORT $ADMIN_SERVER_SSL_PORT $MANAGED_SERVER_PORT $MANAGED_SERVER_SSL_PORT $DEBUG_PORT

WORKDIR $DOMAIN_HOME

# Define default command to start bash.
CMD ["startAdminServer.sh"]
