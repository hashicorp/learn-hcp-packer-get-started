output "artifact_revocation_date" {
  value = data.hcp_packer_artifact.ubuntu_us_east_2.revoke_at
}
