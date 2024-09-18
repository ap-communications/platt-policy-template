package e2e.vendor_x_test

import data.rbac.backstage.global
import data.rbac.backstage.test_utils
import data.rbac_policy
import rego.v1

test_user_is_deny_with_unknown_permission if {
	identity := test_utils.user_identity("vender_x_test_user", ["group:default/VendorX"])
	rbac_policy.decision == global.result_deny with input as test_utils.create_input("unknown.permission", identity)
}
