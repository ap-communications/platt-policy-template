package e2e.vendor_y_test

import data.rbac.backstage.global
import data.rbac.backstage.scaffolder
import data.rbac.backstage.test_utils
import data.rbac_policy
import rego.v1

test_user_is_allowed_with_scaffolder_permissions if {
	identity := test_utils.user_identity("vendor_y_test_user", ["group:default/VendorY"])

	every permission in scaffolder.permissions {
		rbac_policy.decision == global.result_allow with input as test_utils.create_input(permission, identity)
	}
}
