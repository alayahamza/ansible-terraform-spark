module "master" {
  source = "./modules/master"
}

module "workers" {
  source        = "./modules/workers"
  workers_count = var.workers_count
}

data "external" "env" {
  program = ["${path.module}/env.sh"]
}

resource "null_resource" "set_env" {
  provisioner "local-exec" {
    command = "/bin/bash env.sh"
  }
}

resource "local_file" "inventory" {
  filename = "ansible_inventory"
  content = templatefile("ansible_inventory.tftpl",
    {
      master_ip  = module.master.master_ip,
      workers_ips = module.workers.workers_ip,
      root_pass = data.external.env.result["root_pass"]
    }
  )
}

output "master_ip" {
  value = module.master.master_ip
}