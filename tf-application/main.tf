provider "hcp" {}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

data "hcp_packer_iteration" "ubuntu" {
  bucket_name = "learn-packer-ubuntu"
  channel     = "production"
}

data "hcp_packer_image" "ubuntu_us_west_2" {
  bucket_name    = "learn-packer-ubuntu"
  cloud_provider = "aws"
  iteration_id   = data.hcp_packer_iteration.ubuntu.ulid
  region         = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = data.hcp_packer_image.ubuntu_us_west_2.cloud_image_id
  instance_type = "t2.micro"
  tags = {
    Name = "Learn-HCP-Packer"
  }
}
