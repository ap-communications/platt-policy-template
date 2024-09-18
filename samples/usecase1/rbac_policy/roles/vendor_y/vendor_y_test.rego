package rbac_policy.roles.vendor_y_test

import data.rbac.backstage.catalog
import data.rbac.backstage.global
import data.rbac.backstage.scaffolder
import data.rbac.backstage.test_utils
import data.rbac_policy.roles.vendor_y
import rego.v1

test_catalog_read_is_conditional_allow if {
	identity := test_utils.user_identity("test_user", ["group:default/VendorY"])

	expected_result := catalog.result_catalog_conditionional(catalog.is_entity_owner("grouop:default/TeamB"))

	every permission in catalog.read_permissions {
		vendor_y.decision == expected_result with input as _create_input(permission, identity)
	}
}

test_catalog_create_is_allow if {
	identity := test_utils.user_identity("test_user", ["group:default/VendorY"])

	expected_result := global.result_allow

	every permission in catalog.create_permissions {
		vendor_y.decision == expected_result with input as _create_input(permission, identity)
	}
}

test_catalog_delete_is_deny if {
	identity := test_utils.user_identity("test_user", ["group:default/VendorY"])

	expected_result := global.result_deny

	every permission in catalog.delete_permissions {
		vendor_y.decision == expected_result with input as _create_input(permission, identity)
	}
}

test_scaffolder_is_allow if {
	identity := test_utils.user_identity("test_user", ["group:default/VendorY"])

	expected_result := global.result_allow

	every permission in scaffolder.permissions {
		vendor_y.decision == expected_result with input as _create_input(permission, identity)
	}
}

test_unknown_permission_is_deny if {
	identity := test_utils.user_identity("test_user", ["group:default/VendorY"])

	expected_result := global.result_deny

	vendor_y.decision == expected_result with input as _create_input("unknown_permission", identity)
}

test_not_vendor_user_is_not_have_result if {
	identity := test_utils.user_identity("test_user", ["group:default/TeamB"])
	vendor_y with input as _create_input("unknown_permission", identity)
	not vendor_y.decision
}

_create_input(p, i) := test_utils.create_input(p, i)
