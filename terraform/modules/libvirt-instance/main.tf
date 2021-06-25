locals {
  hostnames = toset(var.hostnames)
}


data "ignition_user" "initial_user" {
  name = var.ssh_initial_user
  ssh_authorized_keys = var.ssh_authorized_keys
}

data "ignition_file" "hostname" {
  for_each = local.hostnames
  path = "/etc/hostname"
  content {
    content = "${each.key}.${var.dns_domain}"
  }
}

data "ignition_file" "netconfig" {
  for_each = local.hostnames
  path = "/etc/NetworkManager/system-connections/${var.interface}.nmconnection"
  mode = "384"
  content {
    content = templatefile("${path.module}/nmconnection.tpl", { interface = var.interface, ip = var.ips[each.key], netmask = var.netmask, gateway = var.gateway, dns_server = var.dns_servers[0], dns_domain = var.dns_domain})
  }
}

data "ignition_config" "ignition" {
  for_each = local.hostnames
  files = [
    data.ignition_file.hostname[each.key].rendered,
    data.ignition_file.netconfig[each.key].rendered
  ]
  users = [
    data.ignition_user.initial_user.rendered
  ]
  merge {
    source = var.additional_ignition_config
  }
}


resource "libvirt_pool" "pool" {
  name = var.libvirt_pool_name
  type = "dir"
  path = var.libvirt_pool_path
}

resource "libvirt_volume" "boot_volumes" {
  for_each = local.hostnames
  name   = "${each.key}-boot"
  pool   = libvirt_pool.pool.name
  format = "qcow2"
  size   = var.instance_boot_size

  base_volume_name = var.instance_boot_base_image
  base_volume_pool = var.instance_boot_base_pool
}

resource "libvirt_network" "primary_network" {
  name = var.libvirt_network_name
  mode = var.libvirt_network_type
  bridge = var.libvirt_network_type == "bridge" ? var.libvirt_network_bridge : ""
}

resource "libvirt_ignition" "ignition" {
  for_each = local.hostnames
  name = "${each.key}-ignition"
  pool = libvirt_pool.pool.name
  content = data.ignition_config.ignition[each.key].rendered
}

resource "libvirt_domain" "domains" {
  for_each = local.hostnames
  name = each.key

  vcpu = var.vcpus[each.key]
  cpu = {
    mode = "host-passthrough"
  }

  memory = var.memory[each.key]

  qemu_agent = var.libvirt_network_type == "bridge" ? true : false
  network_interface {
    network_id = libvirt_network.primary_network.id
  }

  disk {
    volume_id = libvirt_volume.boot_volumes[each.key].id
  }

  coreos_ignition = libvirt_ignition.ignition[each.key].id
}
