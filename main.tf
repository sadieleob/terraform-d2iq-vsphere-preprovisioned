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
  name = "sortega-base-os-centos79-konvoy1x"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm1" {
  name             = "${var.cluster_name}-cp1"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  count            = "1"
  folder           = "${var.folder}"

  num_cpus = 4
  memory   = 16384
  guest_id = "centos7_64Guest"
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
        host_name = "${var.cluster_name}-cp1"
        domain = ""
      }
      network_interface {
        ipv4_address = ""
        ipv4_netmask = "24"
      }

      ipv4_gateway = "10.129.1.2"
      dns_suffix_list = ["${var.vsphere_server}"]
      dns_server_list = ["8.8.8.8"]
    }
 }
}

resource "vsphere_virtual_machine" "vm2" {
  name             = "${var.cluster_name}-w1"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  count            = "1"
  folder           = "${var.folder}"

  num_cpus = 8
  memory   = 32768
  guest_id = "centos7_64Guest"
  firmware = "bios"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
   label  = "disk0.vmdk"
    unit_number = 0
    size  = 100
  }

  disk {
   label  = "disk1.vmdk"
    unit_number = 1
    size  = 20
  }
  disk {
   label  = "disk2.vmdk"
    unit_number = 2
    size  = 20
  }
  disk {
   label  = "disk3.vmdk"
    unit_number = 3
    size  = 20
  }

    disk {
   label  = "disk4.vmdk"
    unit_number = 4
    size  = 20
  }

  disk {
   label  = "disk5.vmdk"
    unit_number = 5
    size  = 20
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options{
        host_name = "${var.cluster_name}-w1"
        domain = "${var.vsphere_server}"
      }
      network_interface {
	      ipv4_address = ""
        ipv4_netmask = "24"
      }

      ipv4_gateway = "10.129.1.2"
      dns_suffix_list = ["${var.vsphere_server}"]
      dns_server_list = ["8.8.8.8"]
    }
}
}

resource "vsphere_virtual_machine" "vm3" {
  name             = "${var.cluster_name}-cp2"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  count            = "1"
  folder           = "${var.folder}"

  num_cpus = 4
  memory   = 16384
  guest_id = "centos7_64Guest"
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
        host_name = "${var.cluster_name}-cp2"
        domain = ""
      }
      network_interface {
        ipv4_address = ""
        ipv4_netmask = "24"
      }

      ipv4_gateway = "10.129.1.2"
      dns_suffix_list = ["${var.vsphere_server}"]
      dns_server_list = ["8.8.8.8"]
    }
 }
}

resource "vsphere_virtual_machine" "vm4" {
  name             = "${var.cluster_name}-w2"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  count            = "1"
  folder           = "${var.folder}"

  num_cpus = 8
  memory   = 32768
  guest_id = "centos7_64Guest"
  firmware = "bios"
  
  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
   label  = "disk0.vmdk"
    unit_number = 0
    size  = 100
  }

  disk {
   label  = "disk1.vmdk"
    unit_number = 1
    size  = 50
  }
  disk {
   label  = "disk2.vmdk"
    unit_number = 2
    size  = 50
  }
  disk {
   label  = "disk3.vmdk"
    unit_number = 3
    size  = 50
  }

  disk {
   label  = "disk4.vmdk"
    unit_number = 4
    size  = 50
  }

  disk {
    label = "disk5.vmdk"
    unit_number = 5
    size  = 50
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options{
        host_name = "${var.cluster_name}-w2"
        domain = "${var.vsphere_server}"
      }
      network_interface {
	      ipv4_address = ""
        ipv4_netmask = "24"
      }

      ipv4_gateway = "10.129.1.2"
      dns_suffix_list = ["${var.vsphere_server}"]
      dns_server_list = ["8.8.8.8"]
    }
  }
}

resource "vsphere_virtual_machine" "vm5" {
  name             = "${var.cluster_name}-cp3"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  count            = "1"
  folder           = "${var.folder}"

  num_cpus = 4
  memory   = 16384
  guest_id = "centos7_64Guest"
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
        host_name = "${var.cluster_name}-cp3"
        domain = ""
      }
      network_interface {
        ipv4_address = ""
        ipv4_netmask = "24"
      }

      ipv4_gateway = "10.129.1.2"
      dns_suffix_list = ["${var.vsphere_server}"]
      dns_server_list = ["8.8.8.8"]
    }
 }
}

resource "vsphere_virtual_machine" "vm6" {
  name             = "${var.cluster_name}-w3"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  count            = "1"
  folder           = "${var.folder}"

  num_cpus = 8
  memory   = 32768
  guest_id = "centos7_64Guest"
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
    size  = 50
  }
  disk {
    label = "disk2.vmdk"
    unit_number = 2
    size  = 50
  }
  disk {
    label = "disk3.vmdk"
    unit_number = 3
    size  = 50
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
        host_name = "${var.cluster_name}-w3"
        domain = "${var.vsphere_server}"
      }
      network_interface {
        ipv4_address = ""
        ipv4_netmask = "24"
      }

      ipv4_gateway = "10.129.1.2"
      dns_suffix_list = ["${var.vsphere_server}"]
      dns_server_list = ["8.8.8.8"]
    }
  }
}

resource "vsphere_virtual_machine" "vm7" {
  name             = "${var.cluster_name}-w4"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  count            = "1"
  folder           = "${var.folder}"

  num_cpus = 8
  memory   = 32768
  guest_id = "centos7_64Guest"
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
    size  = 50
  }
  disk {
    label  = "disk2.vmdk"
    unit_number = 2
    size  = 50
  }
  disk {
    label  = "disk3.vmdk"
    unit_number = 3
    size  = 50
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
        host_name = "${var.cluster_name}-w4"
        domain = "${var.vsphere_server}"
      }
      network_interface {
	      ipv4_address = ""
        ipv4_netmask = "24"
      }

      ipv4_gateway = "10.129.1.2"
      dns_suffix_list = ["${var.vsphere_server}"]
      dns_server_list = ["8.8.8.8"]
    }
  }
}
