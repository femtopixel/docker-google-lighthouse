CACHE ?= --no-cache=1
VERSION ?= 0.3.0
FULLVERSION ?= ${VERSION}
archs = arm32v7 amd64 i386
.PHONY: all build publish latest version
all: build publish
build:
	$(foreach arch,$(archs), \
		cat Dockerfile | sed "s/FROM femtopixel\/google-chrome-headless:0.2.0/FROM femtopixel\/google-chrome-headless:0.2.0-$(arch)/g" > .build; \
		if [ $(arch) = arm32v7 ]; then \
			docker build -t femtopixel/google-lighthouse:${VERSION}-$(arch) --build-arg ARM=1 -f .build ${CACHE} .;\
		else \
			docker build -t femtopixel/google-lighthouse:${VERSION}-$(arch) --build-arg ARM=0 -f .build ${CACHE} .;\
		fi;\
	)
publish:
	docker push femtopixel/google-lighthouse
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest2.yaml
	cat manifest2.yaml | sed "s/\$$FULLVERSION/${FULLVERSION}-debian/g" > manifest.yaml
	manifest-tool push from-spec manifest.yaml
latest: build
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest2.yaml
	cat manifest2.yaml | sed "s/\$$FULLVERSION/latest/g" > manifest.yaml
	manifest-tool push from-spec manifest.yaml
