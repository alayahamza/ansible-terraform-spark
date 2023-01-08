# ssh private key to use to connect to node
variable "ssh_private_key_path" {
  type      = string
  default   = "./linode_ssh_key"
  sensitive = true
}

# ssh public key to use to connect to node
variable "ssh_public_key_path" {
  type      = string
  default   = "./linode_ssh_key.pub"
  sensitive = true
}

# Single node for Master and workers (dedicated VMs configuration will be available soon in this repo's other branches)
variable "workers_count" {
  type    = number
  default = 1
}