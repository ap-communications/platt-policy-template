package rbac.backstage.scaffolder

import rego.v1

_make_scaffolder_rule(rule, params) := {
	"resourceType": "scaffolder-template",
	"rule": rule,
	"params": params,
}

_make_action_rule(rule, params) := {
	"resourceType": "scaffolder-action",
	"rule": rule,
	"params": params,
}

_make_task_rule(rule, params) := {
	"resourceType": "scaffolder-task",
	"rule": rule,
	"params": params,
}

# tag: Name of the tag to match on
has_tag(tag) := _make_scaffolder_rule(
	"HAS_TAG",
	{"tag": tag},
)

# actionId: Name of the action id to match on
has_action_id(action_id) := _make_action_rule(
	"HAS_ACTION_ID",
	{"actionId": action_id},
)

# key: key name within the input to match on
# value: value of the given property to match on
has_boolean_property(key, value) := _make_action_rule(
	"HAS_BOOLEAN_PROPERTY",
	{
		"key": key,
		"value": value,
	},
)

# key: key name within the input to match on
# value: value of the given property to match on
has_number_property(key, value) := _make_action_rule(
	"HAS_NUMBER_PROPERTY",
	{
		"key": key,
		"value": value,
	},
)

# key: key name within the input to match on
# value: value of the given property to match on
has_string_property(key, value) := _make_action_rule(
	"HAS_STRING_PROPERTY",
	{
		"key": key,
		"value": value,
	},
)

is_task_owner(array_owners) := _make_task_rule(
	"IS_TASK_OWNER",
	{"createdBy": array_owners},
)
