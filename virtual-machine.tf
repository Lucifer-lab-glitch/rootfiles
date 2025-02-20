#-------------------Resource-group-------------------

module "rg-vm" {
  source         = "../Modules/terraform-azurerm-resourcegroup"
  resource_count = 1
  project        = var.project
  deployment     = local.deployment
  component      = "" #leave the value empty if resource group is not created for a component
  location       = var.location
  tags           = local.common_tags
}

# -------------------- Virtual-Machine Module --------------------
module "vm_complete" {
  source              = "../../Modules/terraform-azurerm-vm"
  project             = var.project
  deployment          = local.deployment
  # VM Deployment Conditions
  deploy_linux_vm     = var.deploy_linux_vm
  deploy_windows_vm   = var.deploy_windows_vm
  vm_name             = var.vm_name
  resource_group_name = local.resource_group_vm 
  location            = var.location
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  admin_password      = module.key_vault.admin_password_secret  #  Retrieves password from Key Vault

  # Networking
  subnet_id          = module.vnet.subnet_id  #  Ensures correct subnet is used
  enable_nsg         = var.enable_nsg
  enable_public_ip   = var.enable_public_ip
  public_ip_id       = var.enable_public_ip ? module.public_ip[0].public_ip_id : null

  # Disk
  disk_storage_account_type = var.disk_storage_account_type
  os_disk_size              = var.os_disk_size

  # Security
  nsg_rules   = var.enable_nsg ? var.nsg_rules : []

  # Identity
  identity_type  = var.identity_type
  identity_ids   = var.identity_ids

  # Auto-Shutdown Logic
  enable_auto_shutdown_windows = var.enable_auto_shutdown_windows
  enable_auto_shutdown_linux   = var.enable_auto_shutdown_linux
  shutdown_schedules           = var.shutdown_schedules

  # Log Analytics
  enable_monitoring         = var.enable_monitoring
  log_analytics_workspace_id = module.log_analytics.workspace_id

  tags = var.tags

  depends_on = [ 
    module.rg-vm,
    module.vnet
   ]
  }  