package rbac_policy.defaults_test

import data.rbac.backstage.test_utils
import data.rbac_policy.defaults
import rego.v1

test_unknown_permision if {
	identity := test_utils.user_identity("test_user", ["group:default/dev_team_1"])
	defaults with input as test_utils.create_input("test.permission", identity)
	not defaults.decision # decision should not defined in this case
}
