packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-ubuntu-linux-basic-{{timestamp}}"
  instance_type = var.instance_type
  region        = var.region
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-bionic-18.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = [var.canonical_ami_owner_id]
  }
  ssh_username = var.ssh_username
  tags = var.tags
}

build {
  sources = [
    "source.amazon-ebs.ubuntu"
  ]


  provisioner "shell" {

    inline = [
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y wget",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install dirmngr gpg-agent",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -qq -",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "echo \"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo DEBIAN_FRONTEND=noninteractive apt-cache policy docker-ce",
      "sudo DEBIAN_FRONTEND=noninteractive apt update -y",
      "sudo DEBIAN_FRONTEND=noninteractive apt install -y docker-ce docker-ce-cli containerd.io"
    ]
  }

  provisioner "inspec" {
    profile = "./tests/basic_image"
  }
}
