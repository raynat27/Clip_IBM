resource "ibm_pi_ike_policy" "ike_policy" {
        pi_cloud_instance_id    = local.cloud_instance_id
        pi_policy_name          = var.ike_policy_name
        pi_policy_dh_group      = 20
        pi_policy_encryption    = "aes-256-cbc"
        pi_policy_key_lifetime  = 28800
        pi_policy_preshared_key = "Lsda5D"
        pi_policy_version       = 2
        pi_policy_authentication = "sha-256"
}

resource "ibm_pi_ipsec_policy" "ipsec_policy" {
        depends_on = [ibm_pi_ike_policy.ike_policy]
        pi_cloud_instance_id    = local.cloud_instance_id
        pi_policy_name          = var.ipsec_policy_name
        pi_policy_dh_group      = 20
        pi_policy_encryption    = "aes-256-cbc"
        pi_policy_key_lifetime  = 28800
        pi_policy_pfs           = true
        pi_policy_authentication = "hmac-sha-256-128"
}

data "ibm_pi_network" "ds_network" {
        pi_network_name = var.network_name
        pi_cloud_instance_id = local.cloud_instance_id
}

resource "ibm_pi_vpn_connection" "vpn_connection" {
        count = var.create_vpn ? 1 : 0
        depends_on = [ibm_pi_ike_policy.ike_policy, ibm_pi_ipsec_policy.ipsec_policy]
        pi_cloud_instance_id    = local.cloud_instance_id
        pi_vpn_connection_name  = var.vpn_name
        pi_ike_policy_id        = ibm_pi_ike_policy.ike_policy.policy_id
        pi_ipsec_policy_id      = ibm_pi_ipsec_policy.ipsec_policy.policy_id
        pi_vpn_connection_mode  = "route"
        pi_networks             = [data.ibm_pi_network.ds_network.id]
        pi_peer_gateway_address = "76.136.223.88"
        pi_peer_subnets         = ["192.1.0.0/24"]
}

data "ibm_pi_key" "ssh_key" {
        pi_key_name          = var.ssh_key_name
        pi_cloud_instance_id = local.cloud_instance_id
}

#data "ibm_pi_image" "power_image" {
#        pi_cloud_instance_id = local.cloud_instance_id
#        pi_image_name        = var.image_name
#}

resource "ibm_pi_instance" "test-instance1" {
        count = var.create_instance ? 1 : 0
        pi_cloud_instance_id = local.cloud_instance_id
        pi_memory            = "4"
        pi_processors        = "0.25"
        pi_instance_name     = var.instance_name
        pi_proc_type         = "shared"
        #pi_image_id          = data.ibm_pi_image.power_image.id
        pi_image_id          = var.catalog_image_id
        pi_key_pair_name     = data.ibm_pi_key.ssh_key.id
        pi_sys_type          = "s922"
        pi_storage_type      = "tier3"

        pi_network {
                network_id  = data.ibm_pi_network.ds_network.id
        }
}

