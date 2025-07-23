locals {
  csv_data = file("${path.module}/data-files/routing_queue.csv")
}

locals {
  queues = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
  divisionnames       = toset([for row in local.queues : row.division])
  skillgroupnames     = toset(compact([for row in local.queues : row.skill_groups]))
  wrapcodenames       = toset(flatten([for row in local.queues : [for code in split(",", row.wrapup_codes) : trimspace(code) if trimspace(code) != ""]]))
  user_promptnames    = toset(flatten([for row in local.queues : trimspace(row.whisper_prompt_name) if row.whisper_prompt_name != ""]))
}

data "genesyscloud_auth_division" "divisions" {
  for_each = toset(local.divisionnames)
  name     = each.key
}

data "genesyscloud_routing_skill_group" "skillgroups" {
  for_each = toset(local.skillgroupnames)
  name     = each.key
}

data "genesyscloud_routing_wrapupcode" "wrapupcodes"{
  for_each = local.wrapcodenames
  name = each.key
}

data "genesyscloud_architect_user_prompt" "user_prompts" {
  for_each = toset(local.user_promptnames)
  name     = each.key
}

resource "genesyscloud_routing_queue" "all_queues" {
  for_each = { for q in local.queues : q.name => q }

  name                     = each.value.name
  division_id              = data.genesyscloud_auth_division.divisions[each.value.division].id
  description              = each.value.description
  acw_wrapup_prompt        = each.value.acw_wrapup_prompt
  acw_timeout_ms           = each.value.acw_wrapup_prompt == "OPTIONAL" || each.value.acw_wrapup_prompt == "MANDATORY" ? 0 : tonumber(each.value.acw_timeout_sec) * 1000
  skill_evaluation_method = each.value.skill_evaluation_method
  skill_groups             = length(trimspace(each.value.skill_groups)) < 1 ? null : [for sg in split(",", each.value.skill_groups) : data.genesyscloud_routing_skill_group.skillgroups[sg].id]
  enable_transcription     = length(trimspace(each.value.enable_transcription)) < 1 ? null : tobool(lower(each.value.enable_transcription))
  enable_manual_assignment = length(trimspace(each.value.enable_manual_assignment)) < 1 ? null : tobool(lower(each.value.enable_manual_assignment))
  media_settings_call {
    alerting_timeout_sec      = tonumber(each.value.call_alerting_timeout_sec)
    service_level_duration_ms = tonumber(each.value.call_service_level_duration_sec) * 1000
    service_level_percentage  = tonumber(each.value.call_service_level_percentage) / 100
  }
  media_settings_callback {
    alerting_timeout_sec      = tonumber(each.value.callback_alerting_timeout_sec)
    service_level_duration_ms = tonumber(each.value.callback_service_level_duration_sec) * 1000
    service_level_percentage  = tonumber(each.value.callback_service_level_percentage) / 100
  }
  media_settings_chat {
    alerting_timeout_sec      = tonumber(each.value.chat_alerting_timeout_sec)
    service_level_duration_ms = tonumber(each.value.chat_service_level_duration_sec) * 1000
    service_level_percentage  = tonumber(each.value.chat_service_level_percentage) / 100
  }
  media_settings_email {
    alerting_timeout_sec      = tonumber(each.value.email_alerting_timeout_sec)
    service_level_duration_ms = tonumber(each.value.email_service_level_duration_sec) * 1000
    service_level_percentage  = tonumber(each.value.email_service_level_percentage) / 100
  }
  media_settings_message {
    alerting_timeout_sec      = tonumber(each.value.message_alerting_timeout_sec)
    service_level_duration_ms = tonumber(each.value.message_service_level_duration_sec) * 1000
    service_level_percentage  = tonumber(each.value.message_service_level_percentage) / 100
  }
  wrapup_codes = length(trimspace(each.value.wrapup_codes)) < 1 ? null : [for name in split(",", each.value.wrapup_codes) : data.genesyscloud_routing_wrapupcode.wrapupcodes[trimspace(name)].id]
  whisper_prompt_id = length(trimspace(each.value.whisper_prompt_name)) < 1 ? null : data.genesyscloud_architect_user_prompt.user_prompts[trimspace(each.value.whisper_prompt_name)].id
  lifecycle {
    ignore_changes = [
      members
    ]
  }
}