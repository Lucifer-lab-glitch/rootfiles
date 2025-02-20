#---------Provider Variables-------------------

variable "tenant_id" {
  type = string
  default = ""
}

variable "client_id" {
  type = string
  default = ""
}
variable "client_secret" {
  type = string
  default = ""
}

variable "subscription_id" {
  type = string
  default = ""
}

#-----Project Variables (used for naming conventions and tags)---------------

#project name
variable "project" {
  type = string
  default = "BD/DPA"
}

#Department
variable "department" {
  type = string
  default = "Cloud"
}

#location
variable "location" {
  type = string
  default = "East US"
}



#---------------Virtual Machine Variables---------------------

# -------------------- VM Deployment -------------------
variable "deploy_linux_vm" {
  description = "Enable or disable the Linux VM deployment"
  type        = bool
  default     = false
}

variable "deploy_windows_vm" {
  description = "Enable or disable the Windows VM deployment"
  type        = bool
  default     = false
}

variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
}

variable "vm_size" {
  description = "The size of the Virtual Machine"
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "adminuser"
}

variable "admin_password" {
  description = "Admin password for the VM (retrieved from Key Vault)"
  type        = string
  sensitive   = true
}

# -------------------- Networking -------------------
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to associate the VM with"
  type        = string
}

variable "enable_nsg" {
  description = "Enable or disable the Network Security Group"
  type        = bool
  default     = true
}

variable "enable_public_ip" {
  description = "Enable or disable the Public IP for the VM"
  type        = bool
  default     = false
}

variable "public_ip_sku" {
  description = "The SKU of the Public IP (Standard or Basic)"
  type        = string
  default     = "Standard"
}

variable "public_ip_id" {
  description = "The ID of the Public IP resource"
  type        = string
  default     = null
}

# -------------------- Disk Configuration -------------------
variable "disk_storage_account_type" {
  description = "The type of storage account for the VM OS disk"
  type        = string
  default     = "Standard_LRS"
}

variable "os_disk_size" {
  description = "The size of the OS disk in GB"
  type        = number
  default     = 30
}

# -------------------- Identity -------------------
variable "identity_type" {
  description = "The type of identity to assign to the VM (SystemAssigned or UserAssigned)"
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "The IDs of the user-assigned identities"
  type        = list(string)
  default     = []
}

# -------------------- Auto-Shutdown -------------------
variable "enable_auto_shutdown_windows" {
  description = "Enable auto-shutdown for Windows VM"
  type        = bool
  default     = false
}

variable "enable_auto_shutdown_linux" {
  description = "Enable auto-shutdown for Linux VM"
  type        = bool
  default     = false
}

variable "shutdown_schedules" {
  description = "Map of auto-shutdown schedules for VMs"
  type = map(object({
    daily_recurrence_time = string
    timezone              = string
    enabled               = bool
    notification_settings = object({
      enabled         = bool
      email           = string
      time_in_minutes = string
      webhook_url     = string
    })
  }))
  default = {}
}

# -------------------- Log Analytics -------------------
variable "enable_monitoring" {
  description = "Enable or disable monitoring for the VM"
  type        = bool
  default     = false
}

variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace"
  type        = string
  default     = null
}

variable "log_analytics_workspace_key" {
  description = "Primary key for the Log Analytics Workspace"
  type        = string
  sensitive   = true
  default     = null
}

# -------------------- Role Assignments -------------------
variable "service_principal_id" {
  description = "The ID of the service principal for role assignments"
  type        = string
}

variable "role_assignments" {
  description = "Map of roles and scopes to assign to the Service Principal"
  type = map(object({
    role_definition_name = string
    scope               = string
  }))
  default = {}
}

# -------------------- Tags -------------------
variable "tags" {
  description = "A map of tags to assign to the Module"
  type        = map(string)
  default     = {}
}

#---------------Network Security Groups Variables---------------------

variable "enable_nsg" {
  description = "Enable or disable NSG creation"
  type        = bool
  default     = false
}

variable "nsgs" {
  description = "Map of NSGs to create"
  type        = map(object({
    location            = string
    resource_group_name = string
  }))
  default = {}
}

variable "nsg_rules" {
  description = "List of NSG rules"
  type        = list(object({
    nsg_name               = string
    name                   = string
    priority               = number
    direction              = string
    access                 = string
    protocol               = string
    source_port_range      = string
    destination_port_range = string
    source_address_prefix  = string
    destination_address_prefix = string
  }))
  default = []
}


#---------------Virtual Network Variables---------------------

variable "virtual_networks" {
  description = "Map of virtual networks to create"
  type        = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    subnets             = map(object({
      name             = string
      address_prefixes = list(string)
      delegations      = optional(list(object({
        name          = string
        service_name  = string
        actions       = list(string)
      })), [])
    }))
  }))
}

variable "enable_nsg" {
  description = "Whether to create network security groups"
  type        = bool
}


variable "enable_network_watcher" {
  description = "Whether to enable network watchers"
  type        = bool
}

variable "enable_flow_logs" {
  description = "Whether to enable flow logs"
  type        = bool
}

variable "log_analytics_workspace_id" {
  description = "ID of the log analytics workspace for traffic analytics"
  type        = string
}

variable "log_retention_days" {
  description = "Retention period for logs in days"
  type        = number
}

variable "enable_traffic_analytics" {
  description = "Whether to enable traffic analytics"
  type        = bool
}

variable "traffic_analytics_interval" {
  description = "Interval for traffic analytics"
  type        = number
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
