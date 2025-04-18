variable "resource_group_name" {
  default = "azure-play-rg"
}

variable "location" {
  default = "eastus"
}

variable "vm_name" {
  default = "azure-play-vm"
}

variable "ssh_public_key_path" {
  description = "Path to your SSH public key"
  default     = "C:/Users/kakan/.ssh/id_ed25519.pub"
}
