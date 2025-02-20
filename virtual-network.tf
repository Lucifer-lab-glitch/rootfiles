#----------------Resource-group------------------

module "rg-vnet" {
  source         = "../Modules/terraform-azurerm-resourcegroup"
  resource_count = 1
  project        = var.project
  deployment     = local.deployment
  component      = "" #leave the value empty if resource group is not created for a component
  location       = var.location
  tags           = local.common_tags
}


# -------------------- Virtual Network Module --------------------
module "vnet" {
  # The source is the path to the VNet module directory.
  source               = "../../Modules/terraform-azurerm-vnet"
  # Call the source module for Virtual Network

  # Pass all necessary variables
  resource_group_name         = var.resource_group_name
  location                    = var.location
  virtual_networks            = var.virtual_networks
  enable_nsg                  = var.enable_nsg
  nsgs                        = var.nsgs
  nsg_rules                   = var.nsg_rules
  enable_network_watcher      = var.enable_network_watcher
  enable_flow_logs            = var.enable_flow_logs
  log_analytics_workspace_id  = var.log_analytics_workspace_id
  log_retention_days          = var.log_retention_days
  enable_traffic_analytics    = var.enable_traffic_analytics
  traffic_analytics_interval  = var.traffic_analytics_interval
  tags                        = var.tags
}
