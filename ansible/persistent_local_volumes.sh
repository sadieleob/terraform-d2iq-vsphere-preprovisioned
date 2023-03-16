#!/bin/bash
sudo mkfs.xfs /dev/sdb -f &&
DISK_UUID=$(sudo blkid -s UUID -o value /dev/sdb) &&
sudo mkdir -p /mnt/disks/$DISK_UUID &&
sudo mount -t xfs /dev/sdb /mnt/disks/$DISK_UUID &&
echo UUID=`sudo blkid -s UUID -o value /dev/sdb` /mnt/disks/$DISK_UUID xfs defaults 0 2 | sudo tee -a /etc/fstab &&
######
sudo mkfs.xfs /dev/sdc -f &&
DISK_UUID=$(sudo blkid -s UUID -o value /dev/sdc) &&
sudo mkdir -p /mnt/disks/$DISK_UUID &&
sudo mount -t xfs /dev/sdc /mnt/disks/$DISK_UUID &&
echo UUID=`sudo blkid -s UUID -o value /dev/sdc` /mnt/disks/$DISK_UUID xfs defaults 0 2 | sudo tee -a /etc/fstab &&
######
sudo mkfs.xfs /dev/sdd -f &&
DISK_UUID=$(sudo blkid -s UUID -o value /dev/sdd) &&
sudo mkdir -p /mnt/disks/$DISK_UUID &&
sudo mount -t xfs /dev/sdd /mnt/disks/$DISK_UUID &&
echo UUID=`sudo blkid -s UUID -o value /dev/sdd` /mnt/disks/$DISK_UUID xfs defaults 0 2 | sudo tee -a /etc/fstab &&
######
sudo mkfs.xfs /dev/sde -f &&
DISK_UUID=$(sudo blkid -s UUID -o value /dev/sde) &&
sudo mkdir -p /mnt/disks/$DISK_UUID &&
sudo mount -t xfs /dev/sde /mnt/disks/$DISK_UUID &&
echo UUID=`sudo blkid -s UUID -o value /dev/sde` /mnt/disks/$DISK_UUID xfs defaults 0 2 | sudo tee -a /etc/fstab &&
######
sudo mkfs.xfs /dev/sdf -f &&
DISK_UUID=$(sudo blkid -s UUID -o value /dev/sdf) &&
sudo mkdir -p /mnt/disks/$DISK_UUID &&
sudo mount -t xfs /dev/sdf /mnt/disks/$DISK_UUID &&
echo UUID=`sudo blkid -s UUID -o value /dev/sdf` /mnt/disks/$DISK_UUID xfs defaults 0 2 | sudo tee -a /etc/fstab
