variable "choco" {}
variable "docker" {}
variable "docker_restart" {}
variable "node_name" {}
variable "project_id" {}
variable "plan_primary" {}
variable "facility" {}

data "template_file" "bootstrap" {
  template = "${file("${path.module}/bootstrap.tpl")}"

  vars = {
    choco          = "${var.choco}"
    docker         = "${var.docker}"
    docker_restart = "${var.docker_restart}"
  }
}

resource "packet_device" "windows_container_node" {
  hostname         = "${var.node_name}"
  operating_system = "windows_2016"
  plan             = "${var.plan_primary}"
  facilities       = ["${var.facility}"]
  user_data        = "${data.template_file.bootstrap.rendered}"
  tags             = ["windows-containers"]

  billing_cycle = "hourly"
  project_id    = "${var.project_id}"

  ip_address_types = ["public_ipv4", "private_ipv4"]
}
