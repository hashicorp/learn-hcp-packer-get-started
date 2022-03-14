provider "hcp" {}

provider "aws" {
  region = var.region
}

data "hcp_packer_image" "ubuntu_us_east_2" {
  bucket_name    = "learn-packer-ubuntu"
  cloud_provider = "aws"
  iteration_id   = var.iteration_id
  region         = "us-east-2"
}

resource "aws_instance" "app_server" {
  count = data.hcp_packer_image.ubuntu_us_east_2.cloud_image_id == "error_revoked" ? 0 : 1

  ami           = data.hcp_packer_image.ubuntu_us_east_2.cloud_image_id
  instance_type = "t2.micro"
  tags = {
    Name = "Learn-HCP-Packer"
  }
}
