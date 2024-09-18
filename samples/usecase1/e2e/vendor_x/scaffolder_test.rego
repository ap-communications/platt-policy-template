package e2e.vendor_x_test

import data.rbac.backstage.global
import data.rbac.backstage.scaffolder
import data.rbac.backstage.test_utils
import data.rbac_policy
import rego.v1

test_user_is_deny_with_scaffolder_permissions if {
	identity := test_utils.user_identity("vendor_x_test_user", ["group:default/VendorX"])

	every permission in scaffolder.permissions {
		rbac_policy.decision == global.result_deny with input as test_utils.create_input(permission, identity)
	}
}
