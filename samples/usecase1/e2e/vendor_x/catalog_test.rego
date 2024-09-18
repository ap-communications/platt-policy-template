package e2e.vendor_x_test

import data.rbac.backstage.catalog
import data.rbac.backstage.global
import data.rbac.backstage.test_utils
import data.rbac_policy
import rego.v1

test_user_is_conditionals_with_catalog_read_permissions if {
	identity := test_utils.user_identity("vender_x_test_user", ["group:default/VendorX"])
	every permission in catalog.read_permissions {
		rbac_policy.decision.result == "CONDITIONAL" with input as test_utils.create_input(permission, identity)
	}
}

test_user_is_conditionals_with_catalog_write_permissions if {
	identity := test_utils.user_identity("vender_x_test_user", ["group:default/VendorX"])
	every permission in catalog.write_permissions {
		rbac_policy.decision == global.result_deny with input as test_utils.create_input(permission, identity)
	}
}
