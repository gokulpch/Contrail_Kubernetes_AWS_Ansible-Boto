#!/bin/bash
############################################################################
######
########## Deploy Kubernetes Dashboard                                 #####
######
############################################################################
URL="https://s3-us-west-2.amazonaws.com/contrail-docker-images/K8Sdashboard.yaml"
echo $(date) 'Running wget...'
wget "${URL}"
echo 'Done Copying File.............'
sleep 60s
kubectl create -f K8Sdashboard.yaml
echo 'Kubernetes Dashboard Created.............'
