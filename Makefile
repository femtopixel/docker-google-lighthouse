CACHE ?= --no-cache=1
VERSION ?= v7.0.1
.PHONY: all build publish latest
all: build publish
build:
	docker build -t femtopixel/google-lighthouse:${VERSION} -t femtopixel/google-lighthouse --build-arg VERSION=${VERSION} ${CACHE} .
publish:
	docker push femtopixel/google-lighthouse -a
