variable "control_nodes" {
  description = "Control node hostnames"
  type = list(string)
  default = ["k8s-control"]
}

variable "control_nodes_vcpus" {
  description = "Control node vcpu count"
  type = number
  default = 2
}

variable "control_nodes_memory" {
  description = "Control node memory size"
  type = number
  default = 2048
}

variable "worker_nodes" {
  description = "Worker node hostnames"
  type = list(string)
  default = ["k8s-worker"]
}

variable "worker_nodes_vcpus" {
  description = "Worker node vcpu count"
  type = number
  default = 4
}

variable "worker_nodes_memory" {
  description = "Worker node memory size"
  type = number
  default = 4096
}
