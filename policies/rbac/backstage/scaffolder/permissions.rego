package rbac.backstage.scaffolder

import rego.v1

action_execute_permission := "scaffolder.action.execute"

template_parameter_read_permission := "scaffolder.template.parameter.read"

template_step_read_permission := "scaffolder.template.step.read"

task_read_permission := "scaffolder.task.read"

task_create_permission := "scaffolder.task.create"

task_cancel_permission := "scaffolder.task.cancel"

template_management_permission := "scaffolder.template.management"

action_permissions := [action_execute_permission]

template_permissions := [
	template_parameter_read_permission,
	template_step_read_permission,
]

task_permissons := [
	task_read_permission,
	task_create_permission,
	task_cancel_permission,
]

permissions := [
	# action_permissions
	action_execute_permission,
	# template_permissions
	template_parameter_read_permission,
	template_step_read_permission,
	# task_permissons
	task_read_permission,
	task_create_permission,
	task_cancel_permission,
	# management permissions
	template_management_permission,
]
