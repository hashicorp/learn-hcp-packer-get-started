output "ubuntu_version" {
  value = data.hcp_packer_version.ubuntu
}

output "ubuntu_us_east_2" {
  value = data.hcp_packer_artifact.ubuntu_us_east_2
}