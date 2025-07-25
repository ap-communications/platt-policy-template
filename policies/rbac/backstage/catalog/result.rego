package rbac.backstage.catalog

import data.rbac.backstage.global
import rego.v1

result_catalog_conditional(conditions) := global.conditional("catalog", "catalog-entity", conditions)
