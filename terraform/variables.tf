variable "tenancy_ocid" {
  type        = string
  description = "OCID of the tenancy"
}

variable "user_ocid" {
  type        = string
  description = "OCID of the user"
}

variable "fingerprint" {
  type        = string
  description = "regional fingerprint"
}

variable "private_key_path" {
  type        = string
  description = "path to private key"
}

variable "region" {
  type        = string
  description = "OCI region"
}

variable "ocpus" {
  type        = number
  description = "number of ocpus in the home lab virtual machine"
  default     = 1
}

variable "ram_in_gbs" {
  type        = number
  description = "value in GBs of the RAM in the home lab virtual machine"
  default     = 4
}

# https://docs.oracle.com/en-us/iaas/images/ - all OS images of oracle cloud
# Get the image ocid from here
variable "oci_image_id" {
  type        = string
  description = "home lab virtual machine os id"
  default     = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaaylmpb4hxkkia6w4s5tqxwlaml7fplqw3bpoc7fovdlr27jpniqoq"
}

variable "ssh_public_key_path" {
  type        = string
  description = "path to the public key"
}
