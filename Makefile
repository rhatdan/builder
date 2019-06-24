IMAGE ?= docker.io/openshift/origin-docker-builder
TAG ?= latest
PROG  := openshift-builder

.PHONY: all build build-image build-devel-image clean test verify

all: build build-image test verify

build:
	hack/build.sh

build-image:
	rm -f "$(PROG)"
	buildah bud -t "$(IMAGE):$(TAG)" .

build-devel-image: build
	buildah bud -t "$(IMAGE):$(TAG)" -f Dockerfile-dev .

test:
	hack/test.sh

verify:
	hack/verify.sh

clean:
	rm -- "$(PROG)"
