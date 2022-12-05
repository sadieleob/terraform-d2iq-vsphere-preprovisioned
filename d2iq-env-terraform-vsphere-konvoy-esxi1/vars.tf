variable "user" {
        default = "asqVkFojmXSt" 
}

variable "password" {
        default = "xCl8QfsX0r15Gp67AU2mjqdc4Va9LS3E"
}
variable "vsphere_server" {
        default = "vcenter.ca1.ksphere-platform.d2iq.cloud"
}

variable "vm_count" {
        default = "3"
}

variable "vm_name" {
        default = "dkp-cp"
}

variable "ip_addr" {
        default = "192.168.2.14"
}

variable "host_name" {
        default = "sortega-dkp-ppp"
}

variable "datastore_id" {
  default = [
    "esxi-08-disk1"
  ]
}

variable "resource_pool" {
  default = [
    "cluster-api"
  ]
}

variable "vsphere_compute_cluster" {
   default = [ 
        "zone1"
]
}
