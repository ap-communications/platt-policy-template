package rbac.backstage.test_utils

import rego.v1

create_input(permission_name, identity) := {
	"permission": {"name": permission_name},
	"identity": identity,
}

user_identity(user_name, claims) := {
	"user": user_name,
	"claims": claims,
}
