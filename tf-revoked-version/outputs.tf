# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "artifact_revocation_date" {
  value = data.hcp_packer_artifact.ubuntu_us_east_2.revoke_at
}
