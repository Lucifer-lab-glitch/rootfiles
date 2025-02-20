#----------------Resource-group------------------

module "rg-nsg" {
  source         = "../Modules/terraform-azurerm-resourcegroup"
  resource_count = 1
  project        = var.project
  deployment     = local.deployment
  component      = "" #leave the value empty if resource group is not created for a component
  location       = var.location
  tags           = local.common_tags
}

# -------------------- Network Security Group Module --------------------
module "nsg_vm" {
  source              = "../../Modules/terraform-azurerm-nsg"
  count               = var.enable_nsg ? 1 : 0  #  NSG is only created if enabled
  project             = var.project
  deployment          = local.deployment
  location            = var.location
  resource_group_name = local.resource_group_nsg 
  tags                = var.tags

  nsgs = var.enable_nsg ? {
    "vm-nsg" = {
      location            = var.location
      resource_group_name = var.resource_group_name
    }
  } : {}

  nsg_rules = var.enable_nsg ? var.nsg_rules : []

  depends_on = [
    module.rg-nsg,
   
  ]
}