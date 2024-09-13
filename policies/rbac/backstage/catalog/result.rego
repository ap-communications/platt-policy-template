package rbac.backstage.catalog

import data.rbac.backstage.global
import rego.v1

result_catalog_conditionional(conditions) := global.conditional("catalog", "catalog-entity", conditions)
