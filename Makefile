
%: %-gitlab
	@true

build-gitlab:
	cd image/ && \
	docker-compose build

run-gitlab: build-gitlab
	cd examples/ && \
	docker-compose up -d

clean-gitlab:
	cd examples/ && \
	docker-compose rm