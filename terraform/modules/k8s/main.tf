module "i-k8s-instances" {
  # we have to use a symlink because upward (..) import is broken
  # (https://github.com/hashicorp/terraform/issues/23333)
  source = "./libvirt-instance"

  libvirt_pool_name = var.libvirt_pool_name
  libvirt_pool_path = var.libvirt_pool_path

  libvirt_network_name = var.libvirt_network_name
  libvirt_network_type = var.libvirt_network_type
  libvirt_network_bridge = var.libvirt_network_bridge

  instance_boot_base_image = var.instance_boot_base_image
  instance_boot_base_pool = var.instance_boot_base_pool
  instance_boot_size = var.instance_boot_size

  hostnames = concat(
    var.control_nodes,
    var.worker_nodes
  )

  vcpus = merge(
    {for host in var.control_nodes: host => var.control_nodes_vcpus},
    {for host in var.worker_nodes: host => var.worker_nodes_vcpus}
  )

  memory = merge(
    {for host in var.control_nodes: host => var.control_nodes_memory},
    {for host in var.worker_nodes: host => var.worker_nodes_memory}
  )

  ips = var.ips
  netmask = var.netmask
  gateway = var.gateway
  interface = var.interface
  dns_servers = var.dns_servers
  dns_domain = var.dns_domain

  ssh_initial_user = var.ssh_initial_user
  ssh_authorized_keys = var.ssh_authorized_keys

  additional_ignition_config = "https://raw.githubusercontent.com/mstefany/ignition/main/k8s.ign"
}
