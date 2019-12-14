output "pool_nodes" {
  description = "Windows Node Addresses"
  value       = "${packet_device.windows_container_node.network.0.address} / ${packet_device.windows_container_node.network.1.address}"
}

output "pool_pws" {
  description = "Node Admin Passwords"
  value       = "${packet_device.windows_container_node.root_password}"
}
