provider "vsphere" {
  user           = var.user
  password       = var.password
  vsphere_server = var.vsphere_server
  # If you have a self-signed cert
  allow_unverified_ssl = false
}
data "vsphere_datacenter" "dc" {
  name = "dc1"
}
data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_resource_pool" "pool" {
  name          = "cluster-api"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.dc.id
}
resource "vsphere_virtual_machine" "cp" {
  name             = "${var.cluster_name}-cp${count.index}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  count            = "3"
  folder           = var.folder
  num_cpus = 4
  memory   = 16384
  guest_id = var.guest_id
  firmware = var.firmware
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label       = "disk0.vmdk"
    unit_number = 0
    size        = 150
  }
  disk {
    label       = "disk1.vmdk"
    unit_number = 1
    size        = 60
  }
  disk {
    label       = "disk2.vmdk"
    unit_number = 2
    size        = 60
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "${var.cluster_name}-cp${count.index}"
        domain    = ""
      }
      network_interface {
        ipv4_address = ""
        ipv4_netmask = "24"
      }
      ipv4_gateway    = var.gateway
      dns_suffix_list = ["${var.vsphere_server}"]
      dns_server_list = ["8.8.8.8"]
    }
  }
}
resource "vsphere_virtual_machine" "w" {
  name             = "${var.cluster_name}-w${count.index}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  count            = "4"
  folder           = var.folder
  num_cpus = 8
  memory   = 32768
  guest_id = var.guest_id
  firmware = var.firmware
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label       = "disk0.vmdk"
    unit_number = 0
    size        = 100
  }
  disk {
    label       = "disk1.vmdk"
    unit_number = 1
    size        = 80
  }
  disk {
    label       = "disk2.vmdk"
    unit_number = 2
    size        = 80
  }
  disk {
    label       = "disk3.vmdk"
    unit_number = 3
    size        = 80
  }
  disk {
    label       = "disk4.vmdk"
    unit_number = 4
    size        = 80
  }
  disk {
    label       = "disk5.vmdk"
    unit_number = 5
    size        = 80
  }
  disk {
    label       = "disk6.vmdk"
    unit_number = 6
    size        = 60
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "${var.cluster_name}-w${count.index}"
        domain    = var.vsphere_server
      }
      network_interface {
        ipv4_address = ""
        ipv4_netmask = "24"
      }
      ipv4_gateway    = var.gateway
      dns_suffix_list = ["${var.vsphere_server}"]
      dns_server_list = ["8.8.8.8"]
    }
  }
}
output "Control_Plane_Nodes_IP_Addresses" {
  value = [replace(join(", " , vsphere_virtual_machine.cp.*.default_ip_address), ",", "")]
  description = "Control Plane Nodes IP addresses."
}
output "Worker_Nodes_IP_Addresses" {
  value = [replace(join(", " , vsphere_virtual_machine.w.*.default_ip_address), ",", "")]
  description = "Worker Nodes IP addresses."
}
