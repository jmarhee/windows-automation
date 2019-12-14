module "node_win" {
  source         = "./modules/windows_container_node"
  choco          = "${var.choco}"
  docker         = "${var.docker}"
  docker_restart = "${var.docker_restart}"
  node_name      = "alpha-ewr1"
  facility       = "${var.facility}"
  plan_primary   = "${var.plan_primary}"
  project_id     = "${var.project_id}"
}
