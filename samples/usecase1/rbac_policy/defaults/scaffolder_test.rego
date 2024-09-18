package rbac_policy.defaults_test

import data.rbac.backstage.global
import data.rbac.backstage.scaffolder
import data.rbac.backstage.test_utils
import data.rbac_policy.defaults
import rego.v1

test_scaffolder_decision_allow if {
	every permission in scaffolder.permissions {
		identity := test_utils.user_identity("test_user", ["group:default/dev_team_1"])
		defaults.decision == global.result_allow with input as test_utils.create_input(permission, identity)
	}
}
