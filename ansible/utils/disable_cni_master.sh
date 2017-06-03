#!/bin/bash
############################################################################
######								       #####
########## Disabling CNI-Network on Master specific to Contrail        #####
######								       #####	
############################################################################
sudo -s <<EOF
echo "Removing Network_args from kubeadm configuration................"
sed -i '/Environment="KUBELET_NETWORK_ARGS=/c\#Environment="KUBELET_NETWORK_ARGS=--network-plugin=cni --cni-conf-dir=/etc/cni/net.d --cni-bin-dir=/opt/cni/bin' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf;
echo "Reloading Daemon................"
systemctl daemon-reload;
echo "Restart Services................"
systemctl restart kubelet.service;
EOF
