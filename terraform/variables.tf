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
