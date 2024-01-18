packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

data "hcp-packer-version" "ubuntu" {
  bucket_name  = "learn-packer-ubuntu"
  channel_name = "production"
}

data "hcp-packer-artifact" "ubuntu-east" {
  bucket_name         = "learn-packer-ubuntu"
  version_fingerprint = data.hcp-packer-version.ubuntu.fingerprint
  platform            = "aws"
  region              = "us-east-2"
}

data "hcp-packer-artifact" "ubuntu-west" {
  bucket_name         = "learn-packer-ubuntu"
  version_fingerprint = data.hcp-packer-version.ubuntu.fingerprint
  platform            = "aws"
  region              = "us-west-1"
}

source "amazon-ebs" "application-east" {
  ami_name = "packer_AWS_{{timestamp}}"

  region         = "us-east-2"
  source_ami     = data.hcp-packer-artifact.ubuntu-east.external_identifier
  instance_type  = "t2.small"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false

  tags = {
    Name = "learn-packer-application"
  }
}

source "amazon-ebs" "application-west" {
  ami_name = "packer_AWS_{{timestamp}}"

  region         = "us-west-1"
  source_ami     = data.hcp-packer-artifact.ubuntu-west.external_identifier
  instance_type  = "t2.small"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false

  tags = {
    Name = "learn-packer-application"
  }
}

build {
  hcp_packer_registry {
    bucket_name = "learn-packer-application"
    description = <<EOT
Some nice description about the image being published to HCP Packer Registry.
    EOT
    bucket_labels = {
      "foo-version" = "3.4.0",
      "foo" = "bar",
    }
  }
  sources = [
    "source.amazon-ebs.application-east",
    "source.amazon-ebs.application-west"
  ]
}
