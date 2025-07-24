terraform {
  required_providers {
    genesyscloud = {
      source = "MyPureCloud/genesyscloud"
    }
  }
}

provider "genesyscloud" {
  oauthclient_id     = var.oauthclient_id
  oauthclient_secret = var.oauthclient_secret
  aws_region         = "ap-southeast-2"
  sdk_debug          = false
}

module "architect_datatable_home" {
  source     = "./modules/architect_datatable"
  division   = "Home"
  csv_files  = ["datatable_sample.csv"]
  depends_on = [module.auth_division]
}

module "architect_datatable_tfdivision" {
  source     = "./modules/architect_datatable"
  division   = "Terraform Division"
  csv_files  = ["datatable_sample2.csv"]
  depends_on = [module.auth_division]
}

# module "architect_emergencygroup" {
#   source      = "./modules/architect_emergencygroup"
#   ivrs_id_map = module.architect_ivr.ivrs

#   depends_on = [ module.flow ]
# }

module "architect_ivr" {
  source                 = "./modules/architect_ivr"
  schedule_groups_id_map = module.architect_schedulegroups.schedule_groups
  depends_on             = [module.flow]
}

module "architect_schedulegroups" {
  source           = "./modules/architect_schedulegroups"
  schedules_id_map = module.architect_schedules.schedules
  depends_on       = [module.auth_division]
}

#Architect schedules must begin on the actual day. EG: If rrule says repeat every Saturday from 23 Sept, but 23 sept is a monday, schedule creation will fail in terraform.
module "architect_schedules" {
  source = "./modules/architect_schedules"
}

module "architect_user_prompt" {
  source = "./modules/architect_user_prompt"
}

module "auth_division" {
  source = "./modules/auth_division"
}

module "group" {
  source = "./modules/group"
}

module "group_roles" {
  source        = "./modules/group_roles"
  groups_id_map = module.group.groups

  depends_on = [module.group]
}

module "flow" {
  source     = "./modules/flow"
  depends_on = [module.auth_division, module.routing_queue]
}

# module "flow_milestone" {
#   source = "./modules/flow_milestone"
# }

# module "flow_outcome" {
#   source = "./modules/flow_outcome"
# }

module "routing_queue" {
  source     = "./modules/routing_queue"
  depends_on = [module.auth_division, module.routing_skill_group, module.routing_wrapupcode, module.architect_user_prompt]
}

module "routing_skill_group" {
  source     = "./modules/routing_skill_group"
  depends_on = [module.auth_division]
}

module "routing_skill" {
  source = "./modules/routing_skill"
}

module "routing_wrapupcode" {
  source     = "./modules/routing_wrapupcode"
  depends_on = [module.auth_division]
}

module "telephony_did_pool" {
  source = "./modules/telephony_did_pool"
}

module "telephony_extension_pool" {
  source = "./modules/telephony_extension_pool"
}
