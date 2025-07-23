locals {
  csv_data = file("${path.module}/data-files/architect_user_prompt.csv") #CSV must be a string for csvdecode function to work - so you must read in the file first
}

locals {
  user_prompts = csvdecode(local.csv_data) #CSV decode will create a map out of the csv string in csv_data
}

resource "genesyscloud_architect_user_prompt" "all_prompts" {
  for_each = { for q in local.user_prompts : q.name => q }

  name        = each.value.name
  description = each.value.description

  resources {
    language = each.value.language
    text     = length(trimspace(each.value.text)) < 1 ? null : each.value.text

    tts_string = length(trimspace(each.value.tts_string)) < 1 ? null : each.value.tts_string

    filename = length(trimspace(each.value.filename)) < 1 ? null : "${path.module}/data-files/prompt-files/${each.value.filename}"

    file_content_hash = length(trimspace(each.value.filename)) < 1 ? null : filesha256("${path.module}/data-files/prompt-files/${each.value.filename}")
  }
}