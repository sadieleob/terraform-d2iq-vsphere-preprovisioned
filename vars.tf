variable "user" {
        default = "" 
}

variable "password" {
        default = ""
}
variable "vsphere_server" {
        default = ""
}

variable "cluster_name" {
        default = ""
}

variable "folder" {
        default = ""
}

variable "guest_id" {
        default = ""
}

variable "firmware" {
        default = ""
}

variable "network" {
        default = ""
}


variable "gateway" {
        default = ""
}

variable "datastore" {
        default = ""
}

variable "template" {
        default = ""
}

variable "custom_attribute_owner" {
  description = "Similar to cloud owner tag"
  type        = string
}

variable "custom_attribute_expiration" {
  description = "Similar to cloud expiration tag"
  type        = string
  default     = ""
}
