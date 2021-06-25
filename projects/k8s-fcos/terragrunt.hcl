include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../terraform/modules/k8s"
}

inputs = {
  # libvirt configuration
  libvirt_pool_name = "k8s"
  libvirt_pool_path = "/srv/virt/k8s"

  libvirt_network_name = "k8s"
  libvirt_network_type = "bridge"
  libvirt_network_bridge = "virbr-int"

  # instance config
  instance_boot_base_pool = "base"
  instance_boot_base_image = "fedora-coreos-33.20210426.3.0-qemu.x86_64.qcow2"

  control_nodes = [
    "k8s-master01",
    "k8s-master02",
    "k8s-master03"
  ]
  control_nodes_vcpus = 2
  control_nodes_memory = 2048

  worker_nodes = [
    "k8s-worker01",
    "k8s-worker02",
    "k8s-worker03",
    "k8s-worker04"
  ]
  worker_nodes_vcpus = 4
  worker_nodes_memory = 4096

  ips = {
    "k8s-master01" = "172.17.2.101"
    "k8s-master02" = "172.17.2.102"
    "k8s-master03" = "172.17.2.103"
    "k8s-worker01" = "172.17.2.111"
    "k8s-worker02" = "172.17.2.112"
    "k8s-worker03" = "172.17.2.113"
    "k8s-worker04" = "172.17.2.114"
  }
  netmask = 16
  gateway = "172.17.255.1"
  dns_servers = ["172.17.255.2"]
  dns_domain = "k8s.stefany.eu"

  ssh_authorized_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzUd6jfpIKjQm/ssfkrF3US9++GTNbOScH1Gw+P640tDIGPPrjnr0FfQ2CJGlKXzCqStqvtFnYLMSDRTu1Zwfc37wJxvr20n6gHm+nX9QyWmfsunA4d1DpThtjJe3VQj+6WNpwPnOc+vbihZEE7ut43tzhQLyodctUqaJg20t+wt+Ldt2koClkEcMImEOlyn6lkkJqwbj+ZpjUQRI9JMC2q7se5EBvDHLsUi5KD9kNJbriseDH4g/LV/XmXML8qvrdxGFShHNPVMlbvpQ4cawt4cm9UTVg0IJ0bJfijnI+yCMuFl6c7oeised2I6CsXMoMKR6fDJoGDl+cnnqOKgksQrXh+LR7cpAjZaBuE8qAa8/3iPjbPP4eA9kt/iu27sZ+W5St2UkoKzpxA6B5QOUpQe9C3+GvmSx725cKMyFPH5nKFCNrXY782h4TriKxKWlX3pv9l3Ezcj09LEN5n4B38X0y0hg8NZ6EbbIgMrVbLtMBQECzPUahGwsGvuYlIi4indfn0oNjkJQ+iLvGZJB5wii6EsQsaeiz778fqOjabu6mbQi9sYJXXj4oKD4LWxkgOZhmrnzJP8OqOmCRf9dAIQIXauhESOhzMmrkA7yFK3Z0wYuHcPN/+AtROLHEZMdUN+56RIccTFTcNKKhFjfY7ATT4RYuggndXHG8bvVdjQ== martin.stefany@gooddata.com",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHIUre0sfSzPI1hO453Zdn8uybCymKOXEGvo9nlNCdvCWm5IOnsCDHXLIVIvYS+/F7aHd6bOfSK6WaSjfxv73+rsDbZyubDNvpfgNzfSsNiCydwm+QIxbEF+RzpfW9HFEs99CIbFDY8psMIgHDkjkE2wB7kxMPpQd9j4VoY7Xr0X1pBe2fC29ZwffQ/JvbgrUX8xrccnQXHlbUwJEoILipTvYEy/i7aspTIPANpws88n1TxPOOjI2zziqPbJ1iD1yl4LqkEa9D3RjBSdoUvisztj8aKqDsz8CL0OBcMEWeVfHZBzMfCnfDDA/LarIjF3iCrm3O0wZUa3HkfpE2jNJSuVuWF7RrurmGNaZfQDqquluJNDRsd1dtlH2HTeHTlHECx7PREDEoS9z5rhSMgkf7j/onMVCxxoIGrGgMrEFS58IWWh+WWDAT1ZZeuSHvStzd9IFeWsrcBqo7Bo+5b5+ajx/4iUaihD/otNJV3dMDbp+IoC/ZlwQ3+T1Z0PFxtG0= martin@srv00.ipa.stefany.eu"
  ]
}
