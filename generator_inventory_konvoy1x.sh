#!/bin/sh env

j=0
for i in $(terraform output -json Control_Plane_Nodes_IP_Addresses | tr -d "[]\""); do export CONTROLPLANE$j=$i;j=$((j+1));done
k=0
for i in $(terraform output -json Worker_Nodes_IP_Addresses | tr -d "[]\""); do export WORKER$k=$i;k=$((k+1));done


cat <<EOF > inventory.yaml
control-plane:
  hosts:
    $CONTROLPLANE0:
      node_pool: control-plane
      ansible_host: "cp0"
      ansible_port: "22"
    $CONTROLPLANE1:
      node_pool: control-plane
      ansible_host: "cp1"
      ansible_port: "22"
    $CONTROLPLANE2:
      node_pool: control-plane
      ansible_host: "cp2"
      ansible_port: "22"
node:
  hosts:
    $WORKER0:
      node_pool: worker
      ansible_host: "w0"
      ansible_port: "22"
    $WORKER1:
      node_pool: worker
      ansible_host: "w1"
      ansible_port: "22"
    $WORKER2:
      node_pool: worker
      ansible_host: "w2"
      ansible_port: "22"
    $WORKER3:
      node_pool: worker
      ansible_host: "w3"
      ansible_port: "22"
all:
  vars:
    ansible_port: 22
    ansible_ssh_private_key_file: "~/.ssh/id_rsa"
    ansible_user: "root"
    control_plane_endpoint: ""
    order: sorted
    version: v1beta1
EOF
envsubst < inventory.yaml

cat <<EOF >> /etc/hosts
$CONTROLPLANE0 $TF_VAR_cluster_name-cp0 cp0
$CONTROLPLANE1 $TF_VAR_cluster_name-cp1 cp1
$CONTROLPLANE2 $TF_VAR_cluster_name-cp2 cp2
$WORKER0 $TF_VAR_cluster_name-w0 w0
$WORKER1 $TF_VAR_cluster_name-w1 w1
$WORKER2 $TF_VAR_cluster_name-w2 w2
$WORKER3 $TF_VAR_cluster_name-w3 w3
EOF
