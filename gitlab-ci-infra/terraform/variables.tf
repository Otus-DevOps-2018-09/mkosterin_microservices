variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "Path to the private key used for privisions access"
}

variable zone {
  description = "Zone for create instance"
  default     = "europe-west1-b"
}

variable bot_count {
  description = "How many bots I should create"
  default     = "2"
}

