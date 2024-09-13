package rbac.backstage.global_test

import data.rbac.backstage.global
import rego.v1

test_is_member_of_truthy if {
	global.is_member_of("user", ["user", "group"])
}

test_is_member_of_falsy if {
	not global.is_member_of("none", ["user", "group"])
}
