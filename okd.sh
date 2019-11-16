#!/usr/bin/env bash

set -x
cd /opt/
wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
tar -zxvf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
cd openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit
 export PATH=/opt/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit:$PATH

yum install -y docker
service docker start

oc cluster up --skip-registry-check=true  --public-hostname=$1