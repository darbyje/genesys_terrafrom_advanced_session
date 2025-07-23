/*
Cleanup TF Export file : 
1. (in TF Export file)Remove :
resource "genesyscloud_auth_division" "Home" {
  home = true
  name = "Home"
}
2. (in TF Export file)replace all from > genesyscloud_auth_division.Home.id
                                    to > data.genesyscloud_auth_division.Home.id

*/

data "genesyscloud_auth_division" "Home" {
  name = "Home"
}

/*
3. Identify or Create a new OAuth and Integration name in Org 
>>>(in current file)Structure the integration with its 'name' as shown below :
    data "genesyscloud_integration" "integration" {
      name = "Genesys Cloud Data Actions"
    }
>>>>(in TF Export file) Add "integration_id = data.genesyscloud_integration.integration.id" into resource "genesyscloud_integration_action" that uses the integration
    resource "genesyscloud_integration_action" "Get_onQueue_Agent_by_QueueId_1571355841" {
      integration_id = data.genesyscloud_integration.integration.id
*/
# data "genesyscloud_integration" "integration1" {
#   name = "Genesys Cloud Data Actions"
# }

/*
4. (in TF Export file)Adding filepath="" into  resource "genesyscloud_flow" "VY-archy_simpleT_export" { 
*/