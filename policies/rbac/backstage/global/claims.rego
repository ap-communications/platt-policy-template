package rbac.backstage.global

import rego.v1

is_member_of(user_or_group, claims) := user_or_group in claims
