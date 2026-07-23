resource "oci_core_virtual_network" "vcn" {

  compartment_id = var.compartment_ocid

  display_name = "oke-vcn"

  cidr_block = "10.0.0.0/16"

  dns_label = "okevcn"
}


resource "oci_core_subnet" "public_subnet" {

  compartment_id = var.compartment_ocid

  vcn_id = oci_core_virtual_network.vcn.id

  cidr_block = "10.0.1.0/24"

  display_name = "public-subnet"

  prohibit_public_ip_on_vnic = false
}


resource "oci_core_subnet" "private_subnet" {

  compartment_id = var.compartment_ocid

  vcn_id = oci_core_virtual_network.vcn.id

  cidr_block = "10.0.2.0/24"

  display_name = "private-subnet"

  prohibit_public_ip_on_vnic = true
}