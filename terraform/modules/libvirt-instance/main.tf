resource "libvirt_volume" "k8s-master01-boot" {
  name   = "k8s-master01-boot"
  pool   = "ssd"
  format = "qcow2"
  size   = 32000000000
}

resource "libvirt_domain" "k8s-master01" {
  name = "k8s-master01"

  vcpu = 2
  memory = 2048

  qemu_agent = true
  network_interface {
    bridge = "virbr-int"
  }

  disk {
    volume_id = libvirt_volume.k8s-master01-boot.id
  }
}
