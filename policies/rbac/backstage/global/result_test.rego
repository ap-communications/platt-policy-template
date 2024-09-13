package rbac.backstage.global_test

import data.rbac.backstage.global
import rego.v1

test_result_allow if {
	global.result_allow == {"result": "ALLOW"}
}

test_result_deny if {
	global.result_deny == {"result": "DENY"}
}

test_result_conditional if {
	plugin_id := "catalog"
	resource_type := "catalog-entity"
	conditions := ["test condition", "test condition 2"]
	global.conditional(plugin_id, resource_type, conditions) == {
		"result": "CONDITIONAL",
		"pluginId": plugin_id,
		"resourceType": resource_type,
		"conditions": conditions,
	}
}
