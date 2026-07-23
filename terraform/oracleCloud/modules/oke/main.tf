resource "oci_containerengine_cluster" "oke_cluster" {

  compartment_id = var.compartment_ocid

  kubernetes_version = var.kubernetes_version

  name = var.cluster_name

  vcn_id = var.vcn_id

  endpoint_config {
    is_public_ip_enabled = true
    subnet_id            = var.subnet_id
  }

}

data "oci_containerengine_cluster_kube_config" "oke" {
  cluster_id = oci_containerengine_cluster.oke_cluster.id

  token_version = "2.0.0"
}

data "oci_containerengine_cluster" "oke" {
  cluster_id = oci_containerengine_cluster.oke_cluster.id
}