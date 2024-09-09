package rbac.backstage.scaffolder_test

import data.rbac.backstage.scaffolder
import rego.v1

test_has_tag if {
	value := "test value"
	tag := scaffolder.has_tag(value)
	tag.resourceType == "scaffolder-template"
	tag.rule == "HAS_TAG"
	tag.params.tag == value
}

test_has_action_id if {
	value := "test value"
	action_id := scaffolder.has_action_id(value)
	action_id.resourceType == "scaffolder-action"
	action_id.rule == "HAS_ACTION_ID"
	action_id.params.actionId == value
}

test_has_boolean_property if {
	key := "test key"
	value := true
	bool_prop := scaffolder.has_boolean_property(key, value)
	bool_prop.resourceType == "scaffolder-action"
	bool_prop.rule == "HAS_BOOLEAN_PROPERTY"
	bool_prop.params.key == key
	bool_prop.params.value == value
}

test_has_number_property if {
	key := "test key"
	value := 99
	number_prop := scaffolder.has_number_property(key, value)
	number_prop.resourceType == "scaffolder-action"
	number_prop.rule == "HAS_NUMBER_PROPERTY"
	number_prop.params.key == key
	number_prop.params.value == value
}

test_has_string_property if {
	key := "test key"
	value := "test value"
	string_prop := scaffolder.has_string_property(key, value)
	string_prop.resourceType == "scaffolder-action"
	string_prop.rule == "HAS_STRING_PROPERTY"
	string_prop.params.key == key
	string_prop.params.value == value
}
