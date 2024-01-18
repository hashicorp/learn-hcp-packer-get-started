provider "hcp" {}

provider "aws" {
  region = var.region
}

data "hcp_packer_version" "ubuntu" {
  bucket_name  = "learn-packer-ubuntu"
  channel_name = "production"
}

data "hcp_packer_artifact" "ubuntu_us_east_2" {
  bucket_name         = "learn-packer-ubuntu"
  platform            = "aws"
  version_fingerprint = data.hcp_packer_version.ubuntu.fingerprint
  region              = "us-east-2"
}

resource "aws_instance" "app_server" {
  ami           = data.hcp_packer_artifact.ubuntu_us_east_2.external_identifier
  instance_type = "t2.micro"
  tags = {
    Name = "Learn-HCP-Packer"
  }
}
