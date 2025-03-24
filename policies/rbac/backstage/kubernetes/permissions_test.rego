package policies.rbac.backstage.kubernetes_test

import data.rbac.backstage.kubernetes
import rego.v1

test_permission_definitions_are_correct if {
	kubernetes.proxy_permission in kubernetes.permissions
	kubernetes.resources_read_permission in kubernetes.permissions
	kubernetes.clucsters_read_permission in kubernetes.permissions
}
