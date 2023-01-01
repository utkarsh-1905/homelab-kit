data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

resource "oci_core_vcn" "homelab-network" {
  compartment_id = var.tenancy_ocid
  cidr_blocks    = ["192.168.0.0/16"]
  display_name   = "homelab-network"
}
resource "oci_core_instance" "homelab_instance" {
  depends_on = [
    oci_core_vcn.homelab-network
  ]
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.tenancy_ocid
  shape               = "VM.Standard.A1.Flex"

  shape_config {
    ocpus         = var.ocpus
    memory_in_gbs = var.ram_in_gbs
  }

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_vcn.homelab-network.id
  }

  preserve_boot_volume = false

  display_name = "home-lab-instance"

  source_details {
    source_type = "image"
    source_id   = var.oci_image_id
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }

}
