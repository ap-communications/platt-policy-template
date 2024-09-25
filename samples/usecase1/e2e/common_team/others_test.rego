package e2e.common_team_test

import data.rbac.backstage.global
import data.rbac.backstage.test_utils
import data.rbac_policy
import rego.v1

test_user_is_deny_with_scaffolder_permission if {
	identity := test_utils.user_identity("common_test_user", ["group:default/TeamA"])
	rbac_policy.decision == global.result_deny with input as test_utils.create_input("unknown.permission", identity)
}
