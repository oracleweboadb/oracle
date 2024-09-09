# Copyright (c) 2014-2018 Oracle and/or its affiliates. All rights reserved.
#
# Script to create and add a Managed Server automatically to the domain's AdminServer running on 'wlsadmin'.
#
# Since: October, 2014
# Author: bruno.borges@oracle.com
#
# =============================
import os
import random
import string
import socket

execfile('/u01/oracle/commonfuncs.py')

# Functions
def randomName():
  return ''.join([random.choice(string.ascii_letters + string.digits) for n in xrange(6)])

# AdminServer details
cluster_name = os.environ.get("CLUSTER_NAME", "DockerCluster")
cluster_address = os.environ.get("CLUSTER_ADDRESS", "WLS_ORDS1:8002")

# ManagedServer details
msinternal = socket.gethostbyname(hostname)
mshost = os.environ.get('MS_HOST', msinternal)
msport = os.environ.get('MS_PORT', '8002')
memargs = os.environ.get('USER_MEM_ARGS', '')
domain_path = os.environ.get("DOMAIN_HOME")

# Connect to the AdminServer
# ==========================
connectToAdmin()

# Create a ManagedServer
# ======================
editMode()

cd('/Servers/%s' % hostname.upper())
cmo.setMachine(getMBean('/Machines/' + nmname))

cd('/Clusters/%s' % cluster_name)
cmo.setClusterAddress(cluster_address)

saveActivate()