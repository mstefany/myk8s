include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../terraform//modules/k8s"
}

inputs = {
  # libvirt configuration
  libvirt_pool_name = "k8s"
  libvirt_pool_path = "/srv/virt/k8s"

  libvirt_network_bridge = "bridge102"

  # instance config
  instance_boot_base_pool = "default"
  # instance_boot_base_image = "fedora-coreos-34.20211004.3.1-qemu.x86_64.qcow2"
  instance_boot_base_image = "flatcar_production_qemu_image.img"

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
#   "k8s-worker05",
#   "k8s-worker06"
  ]
  worker_nodes_vcpus = 4
  worker_nodes_memory = 4096

  ips = {
    "k8s-master01" = "192.168.2.41"
    "k8s-master02" = "192.168.2.42"
    "k8s-master03" = "192.168.2.43"
    "k8s-worker01" = "192.168.2.44"
    "k8s-worker02" = "192.168.2.45"
    "k8s-worker03" = "192.168.2.46"
    "k8s-worker04" = "192.168.2.47"
#   "k8s-worker05" = "192.168.2.48"
#   "k8s-worker06" = "192.168.2.49"
  }
  netmask = 24
  gateway = "192.168.2.1"
  dns_servers = ["192.168.2.1"]
  dns_domain = "stefany.eu"

  ssh_authorized_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzUd6jfpIKjQm/ssfkrF3US9++GTNbOScH1Gw+P640tDIGPPrjnr0FfQ2CJGlKXzCqStqvtFnYLMSDRTu1Zwfc37wJxvr20n6gHm+nX9QyWmfsunA4d1DpThtjJe3VQj+6WNpwPnOc+vbihZEE7ut43tzhQLyodctUqaJg20t+wt+Ldt2koClkEcMImEOlyn6lkkJqwbj+ZpjUQRI9JMC2q7se5EBvDHLsUi5KD9kNJbriseDH4g/LV/XmXML8qvrdxGFShHNPVMlbvpQ4cawt4cm9UTVg0IJ0bJfijnI+yCMuFl6c7oeised2I6CsXMoMKR6fDJoGDl+cnnqOKgksQrXh+LR7cpAjZaBuE8qAa8/3iPjbPP4eA9kt/iu27sZ+W5St2UkoKzpxA6B5QOUpQe9C3+GvmSx725cKMyFPH5nKFCNrXY782h4TriKxKWlX3pv9l3Ezcj09LEN5n4B38X0y0hg8NZ6EbbIgMrVbLtMBQECzPUahGwsGvuYlIi4indfn0oNjkJQ+iLvGZJB5wii6EsQsaeiz778fqOjabu6mbQi9sYJXXj4oKD4LWxkgOZhmrnzJP8OqOmCRf9dAIQIXauhESOhzMmrkA7yFK3Z0wYuHcPN/+AtROLHEZMdUN+56RIccTFTcNKKhFjfY7ATT4RYuggndXHG8bvVdjQ== martin.stefany@gooddata.com",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHIUre0sfSzPI1hO453Zdn8uybCymKOXEGvo9nlNCdvCWm5IOnsCDHXLIVIvYS+/F7aHd6bOfSK6WaSjfxv73+rsDbZyubDNvpfgNzfSsNiCydwm+QIxbEF+RzpfW9HFEs99CIbFDY8psMIgHDkjkE2wB7kxMPpQd9j4VoY7Xr0X1pBe2fC29ZwffQ/JvbgrUX8xrccnQXHlbUwJEoILipTvYEy/i7aspTIPANpws88n1TxPOOjI2zziqPbJ1iD1yl4LqkEa9D3RjBSdoUvisztj8aKqDsz8CL0OBcMEWeVfHZBzMfCnfDDA/LarIjF3iCrm3O0wZUa3HkfpE2jNJSuVuWF7RrurmGNaZfQDqquluJNDRsd1dtlH2HTeHTlHECx7PREDEoS9z5rhSMgkf7j/onMVCxxoIGrGgMrEFS58IWWh+WWDAT1ZZeuSHvStzd9IFeWsrcBqo7Bo+5b5+ajx/4iUaihD/otNJV3dMDbp+IoC/ZlwQ3+T1Z0PFxtG0= martin@srv00.ipa.stefany.eu"
  ]

  updates_day = {
    "k8s-master01" = "Mon"
    "k8s-master02" = "Wed"
    "k8s-master03" = "Fri"
    "k8s-worker01" = "Mon"
    "k8s-worker02" = "Tue"
    "k8s-worker03" = "Wed"
    "k8s-worker04" = "Thu"
#   "k8s-worker05" = "Fri"
#   "k8s-worker06" = "Sat"
  }
}
