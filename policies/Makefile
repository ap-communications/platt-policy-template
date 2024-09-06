.PHONY: check check lint test testRbac

check:
	@opa check .

fmt:
	@opa fmt . --write

lint: check
	@regal lint .

test: testRbac

testRbac:
	@opa test -v rbac
