packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

data "amazon-ami" "ubuntu-xenial-east" {
  region = "us-east-2"
  filters = {
    name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["099720109477"]
}

source "amazon-ebs" "basic-example-east" {
  region = "us-east-2"
  source_ami     = data.amazon-ami.ubuntu-xenial-east.id
  instance_type  = "t2.small"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false
  ami_name       = "packer_AWS_{{timestamp}}"
}

data "amazon-ami" "ubuntu-xenial-west" {
  region = "us-west-2"
  filters = {
    name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["099720109477"]
}

source "amazon-ebs" "basic-example-west" {
  region = "us-west-2"
  source_ami     = data.amazon-ami.ubuntu-xenial-west.id
  instance_type  = "t2.small"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false
  ami_name       = "packer_AWS_{{timestamp}}"
}

build {
  hcp_packer_registry {
    bucket_name = "learn-packer-ubuntu"
    description = <<EOT
Some nice description about the image being published to HCP Packer Registry.
    EOT
    labels = {
      "foo-version" = "3.4.0",
      "foo"         = "bar",
    }
  }
  sources = [
    "source.amazon-ebs.basic-example-east",
    "source.amazon-ebs.basic-example-west"
  ]
}
