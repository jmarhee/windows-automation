variable "auth_token" {
  description = "Your Packet API key"
}

variable "facility" {
  description = "Packet Facility"
  default     = "ewr1"
}

variable "project_id" {
  description = "Packet Project ID"
}

variable "plan_primary" {
  description = "Plan (Defaults to x86 - baremetal_0)"
  default     = "t1.small.x86"
}

variable "node_name" {
  description = "Name of your cluster. Alpha-numeric and hyphens only, please."
  default     = "packet-win-env"
}

variable "docker" {
  default     = "yes"
  description = "Install Docker"
}

variable "choco" {
  default     = "yes"
  description = "Install Chocolately package manager"
}

variable "docker_restart" {
  default     = "yes"
  description = "Reboot system after Docker installation"
}
