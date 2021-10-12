provider "hcp" {}

data "hcp_packer_iteration" "ubuntu" {
  bucket_name = "learn-packer-ubuntu"
  channel     = "production"
}

data "hcp_packer_image" "ubuntu_us_east_2" {
  bucket_name    = "learn-packer-ubuntu"
  cloud_provider = "aws"
  iteration_id   = data.hcp_packer_iteration.ubuntu.ulid
  region         = "us-east-2"
}