#!/bin/sh env

CP_COUNT=$(terraform output -json Control_Plane_Nodes_IP_Addresses | jq '.[1] | length')
W_COUNT=$(terraform output -json Worker_Nodes_IP_Addresses | jq '.[1] | length')

CP_IP_ADDR=$(terraform output -json Control_Plane_Nodes_IP_Addresses | jq '.[0]')
W_IP_ADDR=$(terraform output -json Worker_Nodes_IP_Addresses | jq '.[0]')

#echo $CP_COUNT
#echo $W_COUNT
#echo $CP_IP_ADDR
#echo $W_IP_ADDR

#j=0;for i in $CP_IP_ADDR; do export CONTROLPLANE$j=$i; ((j=j+1)); done

#j=0;for i in $(terraform output -json Control_Plane_Nodes_IP_Addresses | tr -d "[]\""); do echo $i;echo CONTROLPLANE$j;((j=j+1));done
j=0
for i in $(terraform output -json Control_Plane_Nodes_IP_Addresses | tr -d "[]\""); do export CONTROLPLANE$j=$i;j=$((j+1));done
k=0
for i in $(terraform output -json Worker_Nodes_IP_Addresses | tr -d "[]\""); do export WORKER$k=$i;k=$((k+1));done


cat <<EOF > inventory.yaml
control-plane:
  hosts:
    $CONTROLPLANE0:
    $CONTROLPLANE1:
    $CONTROLPLANE2:

node:
  hosts:
    $WORKER0:
      node_pool: worker
    $WORKER1:
      node_pool: worker
    $WORKER2:
      node_pool: worker
    $WORKER3:
      node_pool: worker

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