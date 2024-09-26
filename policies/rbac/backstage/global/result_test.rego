package rbac.backstage.global_test

import data.rbac.backstage.global
import rego.v1

test_result_allow if {
	global.result_allow == {"result": "ALLOW"}
}

test_result_deny if {
	global.result_deny == {"result": "DENY"}
}

# test for conditional
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

test_condition_any_of if {
	condition1 = {
		"resourceType": "catalog-entity",
		"rule": "HAS_LABEL",
		"params": {"label": "test-label"},
	}
	condition2 = {
		"resourceType": "catalog-entity",
		"rule": "IS_ENTITY_OWNER",
		"params": {"claims": ["test-claim-1", "test-claim-2"]},
	}
	children := [condition1, condition2]
	global.condition_any_of(children) == {"anyOf": children}
}

test_condition_all_of if {
	condition1 = {
		"resourceType": "catalog-entity",
		"rule": "HAS_LABEL",
		"params": {"label": "test-label"},
	}
	condition2 = {
		"resourceType": "catalog-entity",
		"rule": "IS_ENTITY_OWNER",
		"params": {"claims": ["test-claim-1", "test-claim-2"]},
	}
	children := [condition1, condition2]
	global.condition_all_of(children) == {"allOf": children}
}

test_condition_not if {
	condition = {
		"resourceType": "catalog-entity",
		"rule": "HAS_LABEL",
		"params": {"label": "test-label"},
	}
	global.condition_not(condition) == {"not": condition}
}

# test for aggregate_conditional_decisions
test_aggregate_conditional_decisions_none if {
	not global.aggregate_conditional_decisions([]) # decision is not defined
}

test_aggregate_conditional_decisions_single if {
	condition1 = {
		"resourceType": "catalog-entity",
		"rule": "HAS_LABEL",
		"params": {"label": "test-label"},
	}
	decision1 := global.conditional("catalog", "catalog-entity", condition1)
	results := [
		{"decision": {"result": "ALLOW"}},
		{"decision": {"result": "DENY"}},
		{"decision": decision1},
	]
	global.aggregate_conditional_decisions(results) == decision1
}

test_aggreate_conditional_decisions_multiple if {
	condition1 = {
		"resourceType": "catalog-entity",
		"rule": "HAS_LABEL",
		"params": {"label": "test-label"},
	}
	decision1 := global.conditional("catalog", "catalog-entity", condition1)
	condition2 = {
		"resourceType": "catalog-entity",
		"rule": "IS_ENTITY_OWNER",
		"params": {"claims": ["test-claim-1", "test-claim-2"]},
	}
	decision2 := global.conditional("catalog", "catalog-entity", condition2)
	results := [
		{"decision": {"result": "ALLOW"}},
		{"decision": {"result": "DENY"}},
		{"decision": decision1},
		{"decision": decision2},
	]
	global.aggregate_conditional_decisions(results) == global.conditional(
		"catalog",
		"catalog-entity",
		global.condition_any_of(sort([condition1, condition2])),
	)
}

test_aggreate_conditional_decisions_multiple_with_dups if {
	condition1 = {
		"resourceType": "catalog-entity",
		"rule": "HAS_LABEL",
		"params": {"label": "test-label"},
	}
	decision1 := global.conditional("catalog", "catalog-entity", condition1)
	condition2 = {
		"resourceType": "catalog-entity",
		"rule": "IS_ENTITY_OWNER",
		"params": {"claims": ["test-claim-1", "test-claim-2"]},
	}
	decision2 := global.conditional("catalog", "catalog-entity", condition2)
	results := [
		{"decision": {"result": "ALLOW"}},
		{"decision": {"result": "DENY"}},
		{"decision": decision1},
		{"decision": decision2},
	]
	global.aggregate_conditional_decisions(results) == global.conditional(
		"catalog",
		"catalog-entity",
		global.condition_any_of(sort([condition1, condition2])),
	)
}

### Unit test for filter_conditional_decisions

test_filter_conditional_decisions_contains_none if {
	results := [
		{"decision": {"result": "ALLOW"}},
		{"decision": {"result": "DENY"}},
	]
	global._filter_conditional_decisions(results) == []
}

test_filter_conditional_decisions_contains_single if {
	condition = {
		"resourceType": "catalog-entity",
		"rule": "HAS_LABEL",
		"params": {"label": "test-label"},
	}
	decision := global.conditional("catalog", "catalog-entity", condition)
	results := [
		{"decision": {"result": "ALLOW"}},
		{"decision": {"result": "DENY"}},
		{"decision": decision},
	]
	global._filter_conditional_decisions(results) == [decision]
}

test_filter_conditional_decisions_contains_multiple if {
	condition1 = {
		"resourceType": "catalog-entity",
		"rule": "HAS_LABEL",
		"params": {"label": "test-label"},
	}
	decision1 := global.conditional("catalog", "catalog-entity", condition1)
	condition2 = {
		"resourceType": "catalog-entity",
		"rule": "IS_ENTITY_OWNER",
		"params": {"claims": ["test-claim-1", "test-claim-2"]},
	}
	decision2 := global.conditional("catalog", "catalog-entity", condition2)
	results := [
		{"decision": {"result": "ALLOW"}},
		{"decision": {"result": "DENY"}},
		{"decision": decision1},
		{"decision": decision2},
	]
	global._filter_conditional_decisions(results) == [decision1, decision2]
}

### Unit test for reduce_conditional_decisions

test_reduce_conditional_decisions_none if {
	not global._reduce_conditional_decisions("pluginId", "res-tyep", []) # decision is not defined
}

test_reduce_conditional_decisions_single if {
	condition = {
		"resourceType": "catalog-entity",
		"rule": "HAS_LABEL",
		"params": {"label": "test-label"},
	}
	global._reduce_conditional_decisions("pluginId", "res-type", [condition]) == global.conditional(
		"pluginId",
		"res-type",
		condition,
	)
}

test_reduce_conditional_decisions_multiple if {
	condition1 = {
		"resourceType": "catalog-entity",
		"rule": "HAS_LABEL",
		"params": {"label": "test-label"},
	}
	condition2 = {
		"resourceType": "catalog-entity",
		"rule": "IS_ENTITY_OWNER",
		"params": {"claims": ["test-claim-1", "test-claim-2"]},
	}
	global._reduce_conditional_decisions("pluginId", "res-type", [condition1, condition2]) == global.conditional(
		"pluginId",
		"res-type",
		global.condition_any_of([condition1, condition2]),
	)
}

# Unit test for _dedupe_conditions

test_dedupe_conditions_no_duped if {
	condition1 = {
		"resourceType": "catalog-entity",
		"rule": "HAS_LABEL",
		"params": {"label": "test-label"},
	}
	condition2 = {
		"resourceType": "catalog-entity",
		"rule": "IS_ENTITY_OWNER",
		"params": {"claims": ["test-claim-1", "test-claim-2"]},
	}
	count(global._dedupe_conditions([condition1, condition2])) == 2
}

test_dedupe_conditions_duped if {
	condition1 = {
		"resourceType": "catalog-entity",
		"rule": "HAS_LABEL",
		"params": {"label": "test-label"},
	}
	condition2 = {
		"resourceType": "catalog-entity",
		"rule": "IS_ENTITY_OWNER",
		"params": {"claims": ["test-claim-1", "test-claim-2"]},
	}
	condition3 = {
		"resourceType": "catalog-entity",
		"rule": "HAS_LABEL",
		"params": {"label": "test-label"},
	}
	count(global._dedupe_conditions([condition1, condition2, condition3])) == 2
}
