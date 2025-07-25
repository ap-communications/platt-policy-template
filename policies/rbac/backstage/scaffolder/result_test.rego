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

test_result_task_conditionional if {
	conditions := ["test condition", "test condition 2"]
	scaffolder.result_task_conditionional(conditions) == {
		"result": "CONDITIONAL",
		"pluginId": "scaffolder",
		"resourceType": "scaffolder-task",
		"conditions": conditions,
	}
}

test_result_task_is_owner if {
	owners := ["owner1", "owner2"]
	scaffolder.result_task_conditionional(scaffolder.is_task_owner(owners)) == {
		"result": "CONDITIONAL",
		"pluginId": "scaffolder",
		"resourceType": "scaffolder-task",
		"conditions": {
			"resourceType": "scaffolder-task",
			"rule": "IS_TASK_OWNER",
			"params": {"createdBy": owners},
		},
	}
}
