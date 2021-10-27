variable "libvirt_pool_name" {
  description = "Libvirt pool name"
  type        = string
  default     = "default"
}

variable "libvirt_pool_path" {
  description = "Libvirt pool backing path"
  type        = string
  default     = "/var/lib/libvirt/images"
}

variable "libvirt_network_bridge" {
  description = "Libvirt network bridge to attach to"
  type = string
  default = ""
}

variable "hostnames" {
  description = "List of VM hostnames"
  type = list(string)
  default = []
}

variable "vcpus" {
  description = "Map of hostnames : vcpus"
  type = map(number)
  default = {}
}

variable "memory" {
  description = "Map of hostnames : memory"
  type = map(number)
  default = {}
}

variable "ips" {
  description = "Map of hostnames : IP addresses"
  type = map(string)
  default = {}
}

variable "netmask" {
  description = "Network mask length"
  type = number
  default = 24
}

variable "gateway" {
  description = "Network gateway"
  type = string
  default = ""
}

variable "interface" {
  description = "Network interface to configure"
  type = string
  default = "ens3"
}

variable "dns_servers" {
  description = "DNS servers"
  type = list(string)
  default = []
}

variable "dns_domain" {
  description = "DNS search domain"
  type = string
  default = ""
}

variable "timezone" {
  description = "Timezone"
  type = string
  default = "Europe/Prague"
}

variable "instance_boot_base_pool" {
  description = "Libvirt pool where base image is located"
  type        = string
  default     = ""
}

variable "instance_boot_base_image" {
  description = "VM boot disk base image name"
  type        = string
  default     = ""
}

variable "instance_boot_size" {
  description = "VM boot disk size"
  type        = number
  default     = 32 * 1024 * 1024 * 1024
}

variable "instance_data_size" {
  description = "VM data disk size"
  type        = number
  default     = 64 * 1024 * 1024 * 1024
}

variable "ssh_initial_user" {
  description = "Initial user available in the image"
  type = string
  default = "core"
}

variable "ssh_authorized_keys" {
  description = "SSH auth keys for initial user"
  type = list(string)
  default = []
}

variable "updates_day" {
  description = "Zincati agent's periodic strategy updates allowed day"
  type = map(string)
  default = {}
}
