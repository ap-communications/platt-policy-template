package rbac.backstage.global

import rego.v1

result_allow := {"result": "ALLOW"}

result_deny := {"result": "DENY"}

condition_any_of(children) := {"anyOf": children}

condition_all_of(children) := {"allOf": children}

condition_not(child) := {"not": child}

# Helper method for constructing a conditional decision
conditional(plugin_id, resource_type, conditions) := {
	"result": "CONDITIONAL",
	"pluginId": plugin_id,
	"resourceType": resource_type,
	"conditions": conditions,
}

_filter_conditional_decisions(results) := [result.decision |
	some result in results
	result.decision.result == "CONDITIONAL"
]

_reduce_conditional_decisions(plugin_id, resource_type, conditions) := decision if {
	count(conditions) == 1
	decision := conditional(plugin_id, resource_type, conditions[0])
} else := decision if {
	count(conditions) > 1
	decision := conditional(plugin_id, resource_type, condition_any_of(conditions))
}

_dedupe_conditions(conditions) := [dedupe |
	map := {c | some c in conditions}
	some dedupe in map
]

aggregate_conditional_decisions(results) := decision if {
	decisions := _filter_conditional_decisions(results)
	count(decisions) > 0
	plugin_id := decisions[0].pluginId
	resource_type := decisions[0].resourceType

	conditions := [decision.conditions | some decision in decisions]
	deduped := _dedupe_conditions(conditions)
	decision := _reduce_conditional_decisions(plugin_id, resource_type, deduped)
}
