package rbac.backstage.scaffolder_test

import data.rbac.backstage.scaffolder
import rego.v1

test_permissions_are_corrected if {
	scaffolder.action_execute_permission in scaffolder.permissions
	scaffolder.template_step_read_permission in scaffolder.permissions
	scaffolder.task_cancel_permission in scaffolder.permissions
	scaffolder.template_management_permission in scaffolder.permissions
}
