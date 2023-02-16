variable "ibm_cloud_api_key" {
  type        = string
  description = "API Key for clip account for user#1"
}

variable "image_name" {
  default     = "custom-image"
  description = "Name of the image to be deployed"
}

variable "power_workspace_crn" {
  type        = string
  #default     = "crn:v1:bluemix:public:power-iaas:us-south:a/e65910fa61ce9072d64902d03f3d4774:6bdf87ba-fb41-43e6-938e-fdfcb8f88ee4::"
  description = "Power Systems Virtual Server CRN reference"
}

variable "network_name" {
  default     = "sub2"
  description = "Name of the LPAR network"
}

variable "instance_name" {
  default     = "jprina-power-1"
  description = "Name of the LPAR instance to be created"
}
variable "create_instance" {
  type        = bool
  default     = false
  description = "If true create LPAR"
}

variable "ike_policy_name" {
  default     = "jprina-ike"
  description = "Name of the VPN IKE Policy"
}

variable "ipsec_policy_name" {
  default     = "jprina-ipsec"
  description = "Name of the VPN IPSec Policy"
}

variable "vpn_name" {
  default     = "jprina-vpn"
  description = "Name of the VPN Connection"
}
variable "create_vpn" {
  type        = bool
  default     = false
  description = "If true create VPN"
}

variable "ssh_key_name" {
  default     = "jprina-ssh"
  description = "Name of the SSH Key"
}

#variable "cloud_instance_id" {
#  default     = "6bdf87ba-fb41-43e6-938e-fdfcb8f88ee4"
#  description = "GUID of Power Workspace"
#}

variable "catalog_image_id" {
  default     = "ba187755-9a08-483a-8b0a-ec820887f4ac"
  description = "OS ID catalog image"
}

#OS List
#ID                                     Name
#dc43fc88-acb7-42e7-855d-a0341ac1708b   7100-05-09
#ba187755-9a08-483a-8b0a-ec820887f4ac   7200-05-03
#bc31d14c-d9d8-477c-a328-34d2f9444e29   7300-00-01 
#a3d34e17-d63c-43a4-a7fd-ee1639ed2eda   IBMi-73-12-2984-1
