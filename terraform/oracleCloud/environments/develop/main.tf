module "networking" {

  source = "../../modules/networking"

  compartment_ocid = var.compartment_ocid

  region = var.region

  tags = local.tags
}

module "oke" {

  source = "../../modules/oke"

  compartment_ocid = var.compartment_ocid

  cluster_name = var.cluster_name

  kubernetes_version = var.kubernetes_version

  public_subnet_id = module.networking.public_subnet_id

  private_subnet_id = module.networking.private_subnet_id

  vcn_id = module.networking.vcn_id

  node_shape = var.node_shape

  node_count = var.node_count

  tags = local.tags
}

module "loadbalancer" {

  source = "../../modules/loadbalancer"

  compartment_ocid = var.compartment_ocid

  public_subnet_id = module.networking.public_subnet_id

  private_subnet_id = module.networking.private_subnet_id

  tags = local.tags
}

resource "oci_containerengine_cluster" "oke_cluster" {

  compartment_id = var.compartment_ocid

  kubernetes_version = var.kubernetes_version

  name = var.cluster_name

  vcn_id = var.vcn_id

  endpoint_config {
    is_public_ip_enabled = true
    subnet_id            = var.public_subnet_id
  }
}


resource "oci_containerengine_node_pool" "workers" {

  cluster_id = oci_containerengine_cluster.oke_cluster.id

  compartment_id = var.compartment_ocid

  kubernetes_version = var.kubernetes_version

  name = "${var.cluster_name}-workers"

  node_shape = var.node_shape

  node_config_details {

    size = var.node_count

    placement_configs {

      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name

      subnet_id = var.private_subnet_id
    }
  }

  node_shape_config {

    ocpus = 1

    memory_in_gbs = 16
  }
}