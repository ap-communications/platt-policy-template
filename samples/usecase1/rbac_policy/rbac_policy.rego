package rbac_policy

import data.rbac.backstage.global
import rego.v1

decision := global.result_allow if {
	# some of the roles may allow the decision
	some role in data.rbac_policy.roles
	role.decision == global.result_allow
} else := global.result_deny if {
	# some of the roles may deny the decision
	some role in data.rbac_policy.roles
	role.decision == global.result_deny
} else := aggregate_decision if {
	results := [result | some result in data.rbac_policy.roles]
	aggregate_decision := global.aggregate_conditional_decisions(data.rbac_policy.roles)
} else := default_decision if {
	default_decision := data.rbac_policy.defaults.decision
} else := global.result_deny
