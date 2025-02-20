#---------------------------VM Module-------------------------

# VM Configuration
deploy_linux_vm    = true
deploy_windows_vm  = false
vm_name            = "my-vm"
vm_size            = "Standard_B2s"
admin_username     = "adminuser"

# Networking
resource_group_name = "rg"
location           = "eastus"
subnet_id          = "/subscriptions/xxxx/resourceGroups/rg/providers/Microsoft.Network/virtualNetworks/my-vnet/subnets/my-subnet"
enable_nsg         = true
enable_public_ip   = false
public_ip_sku      = "Standard"

# Disk Configuration
disk_storage_account_type = "Standard_LRS"
os_disk_size              = 30


# Security & NSG
nsg_rules = [
  {
    nsg_name               = "vm-nsg"
    name                   = "Allow-SSH"
    priority               = 100
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "22"
    source_address_prefix  = "*"
    destination_address_prefix = "*"
  },
  {
    nsg_name               = "vm-nsg"
    name                   = "Allow-RDP"
    priority               = 110
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "3389"
    source_address_prefix  = "*"
    destination_address_prefix = "*"
  }
]

# Identity
identity_type = "SystemAssigned"
identity_ids  = []

# Auto-Shutdown Configuration
enable_auto_shutdown_windows = true
enable_auto_shutdown_linux   = true

shutdown_schedules = {
  linux_vm = {
    daily_recurrence_time = "1900"
    timezone              = "UTC"
    enabled               = true
    notification_settings = {
      enabled         = true
      email           = "admin@example.com"
      time_in_minutes = "30"
      webhook_url     = "https://webhook.site"
    }
  }
}

# Log Analytics
enable_monitoring           = true
log_analytics_workspace_id  = "/subscriptions/xxxx/resourceGroups/rg/providers/Microsoft.OperationalInsights/workspaces/my-log-workspace"
log_analytics_workspace_key = "xxxxxx"

# Role Assignments
service_principal_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

role_assignments = {
  contributor = {
    role_definition_name = "Contributor"
    scope               = "/subscriptions/xxxx/resourceGroups/rg"
  }
  reader = {
    role_definition_name = "Reader"
    scope               = "/subscriptions/xxxx/resourceGroups/rg"
  }
}

# Tags
tags = {
  Environment = "Dev"
  Owner       = "CloudOps"
}


#---------------------------Vnet Module-------------------------

# Resource group configuration
#resource_group_name = "example-resource-group"
#location            = "East US"

# General project and environment metadata
project     = "example-project"
#environment = "dev"

# Virtual network configurations
virtual_networks = {
  example-vnet = {
    name                = "example-vnet"
    location            = "East US"
    resource_group_name = "example-resource-group"
    address_space       = ["10.0.0.0/16"]
    subnets = {
      frontend = {
        name             = "frontend"
        address_prefixes = ["10.0.1.0/24"]
      },
      backend = {
        name             = "backend"
        address_prefixes = ["10.0.2.0/24"]
      }
    }
  }
}

# Network Security Groups
#enable_nsg = true
nsgs = {
  "frontend-nsg" = {
    location            = "East US"
    resource_group_name = "example-resource-group"
  }
}

#nsg_rules = {
#  "allow-http" = {
#    nsg_name               = "frontend-nsg"
#    priority               = 100
#    direction              = "Inbound"
#    access                 = "Allow"
#    protocol               = "Tcp"
#    source_port_range      = "*"
#    destination_port_range = "80"
#    source_address_prefix  = "*"
#    destination_address_prefix = "*"
#  },
#  "allow-https" = {
#    nsg_name               = "frontend-nsg"
#    priority               = 110
#    direction              = "Inbound"
#    access                 = "Allow"
#    protocol               = "Tcp"
#    source_port_range      = "*"
#    destination_port_range = "443"
#    source_address_prefix  = "*"
#    destination_address_prefix = "*"
#  }
#}

# Network watcher settings
enable_network_watcher = true

# Flow logs and log analytics workspace
enable_flow_logs                = true
# log_analytics_workspace_id      = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resource-group/providers/Microsoft.OperationalInsights/workspaces/example-law"
log_retention_days              = 30
enable_traffic_analytics        = true
traffic_analytics_interval      = 10

# Tags to apply to all resources
# tags = {
  # owner        = "example-owner"
  # cost_center  = "example-cost-center"
# }

