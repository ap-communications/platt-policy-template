package rbac.backstage.scaffolder_test

import data.rbac.backstage.scaffolder
import rego.v1

test_result_template_conditionional if {
	conditions := ["test condition", "test condition 2"]
	scaffolder.result_template_conditionional(conditions) == {
		"result": "CONDITIONAL",
		"pluginId": "scaffolder",
		"resourceType": "scaffolder-template",
		"conditions": conditions,
	}
}

test_result_action_conditionional if {
	conditions := ["test condition", "test condition 2"]
	scaffolder.result_action_conditionional(conditions) == {
		"result": "CONDITIONAL",
		"pluginId": "scaffolder",
		"resourceType": "scaffolder-action",
		"conditions": conditions,
	}
}
