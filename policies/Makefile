.PHONY: check check lint test testRbac

checkAll: fmt check lint test

check:
	@opa check .

fmt:
	@opa fmt . --write

lint: check
	@regal lint .

test: testRbac

testRbac:
	@opa test -v rbac
