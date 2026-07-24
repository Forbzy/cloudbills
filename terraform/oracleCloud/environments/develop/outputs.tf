output "cluster_id" {
  value = module.oke.cluster_id
}

output "kubeconfig" {
  value     = module.oke.kubeconfig
  sensitive = true
}

output "vcn_id" {
  value = module.networking.vcn_id
}

output "public_subnet_id" {
  value = oci_core_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = oci_core_subnet.private_subnet.id
}