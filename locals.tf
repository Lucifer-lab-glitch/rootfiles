#---------------Environment--------------------
locals {
  deployment = lower(terraform.workspace)
}

#----------------Common Tags-------------------
locals {
  common_tags = {
    ProjectName  = "${var.project}"
    Env          = "${local.deployment}"
    BusinessUnit = "${var.department}"
    Location     = "${var.location}"
  }
}


#-----------------Resource Group List--------------------

locals {

 resource_group_vnet       = flatten(module.rg-vnet.*.rgname)
 resource_group_vm         = flatten(module.rg-vm.*.rgname)
 resource_group_nsg        = flatten(module.rg-nsg.*.rgname)

}