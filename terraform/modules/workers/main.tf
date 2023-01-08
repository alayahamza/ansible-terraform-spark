data "external" "env" {
  program = ["${path.module}/../../env.sh"]
}

resource "null_resource" "set_env" {
  provisioner "local-exec" {
    command = "/bin/bash env.sh"
  }
}

output "workers_ip" {
  value = linode_instance.workers.*.ip_address
}

resource "linode_instance" "workers" {
  count           = var.workers_count
  image           = "linode/centos7"
  label           = "worker-${count.index}"
  group           = "workers"
  region          = "eu-west"
  type            = "g6-standard-2"
  authorized_keys = []
  root_pass       = data.external.env.result["root_pass"]
}