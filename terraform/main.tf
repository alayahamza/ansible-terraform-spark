data "external" "env" {
  program = ["${path.module}/env.sh"]
}

output "nodes_ip" {
  value = linode_instance.nodes.*.ip_address
}

resource "null_resource" "set_env" {
  provisioner "local-exec" {
    command = "/bin/bash env.sh"
  }
}

resource "local_file" "inventory" {
  filename = "ansible_inventory"
  content = templatefile("${path.module}/ansible_inventory.tftpl",
    {
      nodes = linode_instance.nodes.*.ip_address
    }
  )
}

resource "linode_instance" "nodes" {
  count           = var.node_count
  image           = "linode/ubuntu20.04"
  label           = "node-${count.index}"
  group           = "node"
  region          = "eu-west"
  type            = "g6-standard-2"
  authorized_keys = []
  root_pass       = data.external.env.result["root_pass"]
}

resource "null_resource" "ansible" {
  count = var.node_count
  triggers = {
    key = uuid()
  }

  connection {
    host     = element(linode_instance.nodes.*.ip_address, count.index)
    type     = "ssh"
    user     = "root"
    password = data.external.env.result["root_pass"]
    # private_key = file(var.ssh_private_key_path)
  }
  provisioner "remote-exec" {
    inline = [
      "Node creation: Done!",
      "sudo apt-get update -y"
    ]
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible_inventory  ../playbook.yml"
  }
}
