data "external" "env" {
  program = ["${path.module}/../../env.sh"]
}

resource "null_resource" "set_env" {
  provisioner "local-exec" {
    command = "/bin/bash env.sh"
  }
}

output "master_ip" {
  value = linode_instance.master.ip_address
}

resource "linode_instance" "master" {
  image           = "linode/centos7"
  label           = "master"
  group           = "master"
  region          = "eu-west"
  type            = "g6-standard-2"
  authorized_keys = []
  root_pass       = data.external.env.result["root_pass"]
}