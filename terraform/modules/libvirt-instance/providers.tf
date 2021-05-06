terraform {
  required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
    }
    ignition = {
      source = "terraform-providers/ignition"
    }
  }
}
