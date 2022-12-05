provider "vsphere" {
  user           = "${var.user}"
  password       = "${var.password}"
  vsphere_server = "${var.vsphere_server}"

  # If you have a self-signed cert
  allow_unverified_ssl = false
}

data "vsphere_datacenter" "dc" {
 name = "dc1"
}

data "vsphere_datastore" "datastore" {
 name          = "esxi-08-disk3"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "cluster-api"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "Airgapped"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name = "sortega-base-os-rhel79-cluster-api-ppp"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm1" {
  name             = "sortega-dkp-ppp-rhel84-cp3"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  count            = "1"
  folder           = "cluster-api/sortega"

  num_cpus = 4
  memory   = 16384
  guest_id = "rhel7_64Guest"
  firmware = "bios"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
   label  = "disk0.vmdk"
    unit_number = 0
    size  = 100
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options{
        host_name = "sortega-dkp-ppp-rhel84-cp3"
        domain = ""
      }
      network_interface {
        ipv4_address = ""
        ipv4_netmask = "24"
      }

      ipv4_gateway = "10.129.1.2"
      dns_suffix_list = ["vcenter.ca1.ksphere-platform.d2iq.cloud"]
      dns_server_list = ["8.8.8.8"]
    }
 }
}

resource "vsphere_virtual_machine" "vm2" {
  name             = "sortega-dkp-ppp-rhel84-w3"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  count            = "1"
  folder           = "cluster-api/sortega"

  num_cpus = 8
  memory   = 32768
  guest_id = "rhel7_64Guest"
  firmware = "bios"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label = "disk0.vmdk"
    unit_number = 0
    size  = 100
  }
  disk {
    label = "disk1.vmdk"
    unit_number = 1
    size  = 150
  }
  disk {
    label = "disk2.vmdk"
    unit_number = 2
    size  = 150
  }
  disk {
    label = "disk3.vmdk"
    unit_number = 3
    size  = 150
  }

  disk {
    label = "disk4.vmdk"
    unit_number = 4
    size  = 20
  }

  disk {
    label = "disk5.vmdk"
    unit_number = 5
    size  = 30
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options{
        host_name = "ksortega-dkp-ppp-rhel84-w3"
        domain = "vcenter.ca1.ksphere-platform.d2iq.cloud"
      }
      network_interface {
        ipv4_address = ""
        ipv4_netmask = "24"
      }

      ipv4_gateway = "10.129.1.2"
      dns_suffix_list = ["vcenter.ca1.ksphere-platform.d2iq.cloud"]
      dns_server_list = ["8.8.8.8"]
    }
  }
}

resource "vsphere_virtual_machine" "vm3" {
  name             = "sortega-dkp-ppp-rhel84-w4"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  count            = "1"
  folder           = "cluster-api/sortega"

  num_cpus = 8
  memory   = 32768
  guest_id = "rhel7_64Guest"
  firmware = "bios"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label  = "disk0.vmdk"
    unit_number = 0
    size = 100
  }
  disk {
    label  = "disk1.vmdk"
    unit_number = 1
    size  = 150
  }
  disk {
    label  = "disk2.vmdk"
    unit_number = 2
    size  = 150
  }
  disk {
    label  = "disk3.vmdk"
    unit_number = 3
    size  = 150
  }
  
  disk {
    label  = "disk4.vmdk"
    unit_number = 4
    size  = 50
  }

  disk {
    label  = "disk5.vmdk"
    unit_number = 5
    size  = 50
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options{
        host_name = "sortega-dkp-ppp-rhel84-w4"
        domain = "vcenter.ca1.ksphere-platform.d2iq.cloud"
      }
      network_interface {
	      ipv4_address = ""
        ipv4_netmask = "24"
      }

      ipv4_gateway = "10.129.1.2"
      dns_suffix_list = ["vcenter.ca1.ksphere-platform.d2iq.cloud"]
      dns_server_list = ["8.8.8.8"]
    }
  }
}