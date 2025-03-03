test: .build-tmp/build-image src/* test/*
	docker run --rm -it -v ${PWD}/src:/app/src:ro -v ${PWD}/test:/app/test:ro rgpm:test

build: .build-tmp/build-image src/* test/*

install:
	yarn install --frozen-lockfile

.build-tmp/build-image: Dockerfile package.json yarn.lock
	docker build -t rgpm -t rgpm:test .
	mkdir -p .build-tmp
	@touch $@

clean:
	rm -rf .build-tmp

clean-docker:
	docker rmi rgpm:latest rgpm:test

clean-all: clean clean-docker

.PHONY: build test install clean

