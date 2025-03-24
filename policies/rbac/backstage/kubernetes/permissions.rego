package rbac.backstage.kubernetes

import rego.v1

proxy_permission := "kubernetes.proxy"

resources_read_permission := "kubernetes.resources.read"

clucsters_read_permission := "kubernetes.clusters.read"

permissions := [
	proxy_permission,
	resources_read_permission,
	clucsters_read_permission,
]
