SPEC_VERSION ?= 10.0

validate:
	@swagger-cli validate \
		--no-schema \
		specs/${SPEC_VERSION}/spec.yml

build:
	@go run . ${SPEC_VERSION} jsonnet

bundle: build validate
	@swagger-cli bundle \
		--dereference \
		--outfile _gen/${SPEC_VERSION}/spec.json \
		specs/${SPEC_VERSION}/spec.yml

drone:
	drone lint
	drone --server https://drone.grafana.net sign --save grafana/dashboard-spec

.PHONY: validate build bundle drone

.PHONY: tests
tests:
	bash tests.sh