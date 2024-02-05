# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "ubuntu_version" {
  value = data.hcp_packer_version.ubuntu
}

output "ubuntu_us_east_2" {
  value = data.hcp_packer_artifact.ubuntu_us_east_2
}