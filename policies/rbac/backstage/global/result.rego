package rbac.backstage.global

import rego.v1

result_allow := {"result": "ALLOW"}

result_deny := {"result": "DENY"}

# Helper method for constructing a conditional decision
conditional(plugin_id, resource_type, conditions) := {
	"result": "CONDITIONAL",
	"pluginId": plugin_id,
	"resourceType": resource_type,
	"conditions": conditions,
}
