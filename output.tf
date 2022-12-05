#output "virtual_machine_names" {
#  description = "ID of the VM"
#  value       = vsphere_virtual_machine.*.name
#}
#
#output "virtual_machine_ip_addr" {
#  description = "Public IP address of the EC2 instance"
#  value       = vsphere_virtual_machine.vm1.*.clone.0.customize.0.network_interface.0.ipv4_address
#}
