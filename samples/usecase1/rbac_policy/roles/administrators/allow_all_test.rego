package rbac_policy.roles.administrators_test

import data.rbac.backstage.global
import data.rbac.backstage.test_utils
import data.rbac_policy.roles.administrators
import rego.v1

test_user_is_administrator if {
	identity := test_utils.user_identity("test_user", ["group:default/administrators"])
	administrators.decision == global.result_allow with input as test_utils.create_input("test_permission", identity)
}

test_user_is_not_administrator if {
	identity := test_utils.user_identity("test_user", ["group:default/dev_team_1"])
	administrators with input as test_utils.create_input("test_permission", identity)
	not administrators.decision # decision should not defined in this case
}
