NARC_VERSION=$(shell curl -s https://api.github.com/repos/nanopack/narc/releases/latest -s | jq .name -r)
LIBBFRAME_VERSION=$(shell curl -s https://api.github.com/repos/nanobox-io/bframe-c/releases/latest -s | jq .name -r)
LIBMSGXCHNG_VERSION=$(shell curl -s https://api.github.com/repos/nanobox-io/msgxchng-c/releases/latest -s | jq .name -r)
RED_VERSION=$(shell curl -s https://api.github.com/repos/nanopack/red/releases/latest -s | jq .name -r)
REDD_VERSION=$(shell curl -s https://api.github.com/repos/nanopack/redd/releases/latest -s | jq .name -r)
LIBMSGPACK3_VERSION=0.5.9-1

all: narc libbframe libmsgpack3-18.04 libmsgxchng libmsgxchng-18.04 red redd

pkg:
	mkdir pkg

pkg/deb: pkg
	mkdir pkg/deb

PHONY: ubuntu

ubuntu:
	docker build -t nanobox/fpm-cookery:ubuntu -f Dockerfiles/Dockerfile.ubuntu Dockerfiles

PHONY: ubuntu-18.04

ubuntu-18.04:
	docker build -t nanobox/fpm-cookery:ubuntu-18.04 -f Dockerfiles/Dockerfile.ubuntu-18.04 Dockerfiles

PHONY: narc-docker

narc-docker: ubuntu
	docker build --build-arg NARC_VERSION=${NARC_VERSION} -t nanobox/fpm-cookery:narc narc

PHONY: narc

narc: pkg/deb/narc_${NARC_VERSION}_amd64.deb

pkg/deb/narc_${NARC_VERSION}_amd64.deb: pkg/deb narc-docker
	docker run --rm nanobox/fpm-cookery:narc > pkg/deb/narc_${NARC_VERSION}_amd64.deb

PHONY: publish-narc

publish-narc: pkg/deb/narc_${NARC_VERSION}_amd64.deb
	aws s3 cp pkg/deb/narc_${NARC_VERSION}_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
	aws cloudfront create-invalidation --distribution-id ${CLOUDFRONT_DISTRIBUTION_ID} --paths deb/narc_${NARC_VERSION}_amd64.deb

publish-narc-dryrun: pkg/deb/narc_${NARC_VERSION}_amd64.deb
	aws s3 cp pkg/deb/narc_${NARC_VERSION}_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --dryrun

PHONY: libbframe-docker

libbframe-docker: ubuntu
	docker build --build-arg LIBBFRAME_VERSION=${LIBBFRAME_VERSION} -t nanobox/fpm-cookery:libbframe libbframe

PHONY: libbframe

libbframe: pkg/deb/libbframe_${LIBBFRAME_VERSION}_amd64.deb

pkg/deb/libbframe_${LIBBFRAME_VERSION}_amd64.deb: pkg/deb libbframe-docker
	docker run --rm nanobox/fpm-cookery:libbframe > pkg/deb/libbframe_${LIBBFRAME_VERSION}_amd64.deb

PHONY: publish-libbframe

publish-libbframe: pkg/deb/libbframe_${LIBBFRAME_VERSION}_amd64.deb
	aws s3 cp pkg/deb/libbframe_${LIBBFRAME_VERSION}_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers 
	aws cloudfront create-invalidation --distribution-id ${CLOUDFRONT_DISTRIBUTION_ID} --paths deb/libbframe_${LIBBFRAME_VERSION}_amd64.deb

publish-libbframe-dryrun: pkg/deb/libbframe_${LIBBFRAME_VERSION}_amd64.deb
	aws s3 cp pkg/deb/libbframe_${LIBBFRAME_VERSION}_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers  --dryrun

PHONY: libmsgpack3-18.04-docker

libmsgpack3-18.04-docker: ubuntu-18.04
	docker build --build-arg LIBMSGPACK3_VERSION=${LIBMSGPACK3_VERSION} -t nanobox/fpm-cookery:libmsgpack3-18.04 -f libmsgpack3/Dockerfile-18.04 libmsgpack3

PHONY: libmsgpack3-18.04

libmsgpack3-18.04: pkg/deb/libmsgpack3_${LIBMSGPACK3_VERSION}_18.04_amd64.deb

pkg/deb/libmsgpack3_${LIBMSGPACK3_VERSION}_18.04_amd64.deb: pkg/deb libmsgpack3-18.04-docker
	docker run --rm nanobox/fpm-cookery:libmsgpack3-18.04 > pkg/deb/libmsgpack3_${LIBMSGPACK3_VERSION}_18.04_amd64.deb

PHONY: publish-libmsgpack3-18.04

publish-libmsgpack3-18.04: pkg/deb/libmsgpack3_${LIBMSGPACK3_VERSION}_18.04_amd64.deb
	aws s3 cp pkg/deb/libmsgpack3_${LIBMSGPACK3_VERSION}_18.04_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
	aws cloudfront create-invalidation --distribution-id ${CLOUDFRONT_DISTRIBUTION_ID} --paths deb/libmsgpack3_${LIBMSGPACK3_VERSION}_18.04_amd64.deb

publish-libmsgpack3-18.04-dryrun: pkg/deb/libmsgpack3_${LIBMSGPACK3_VERSION}_18.04_amd64.deb
	aws s3 cp pkg/deb/libmsgpack3_${LIBMSGPACK3_VERSION}_18.04_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --dryrun

PHONY: libmsgxchng-docker

libmsgxchng-docker: ubuntu
	docker build --build-arg LIBMSGXCHNG_VERSION=${LIBMSGXCHNG_VERSION} -t nanobox/fpm-cookery:libmsgxchng libmsgxchng

PHONY: libmsgxchng

libmsgxchng: pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_amd64.deb

pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_amd64.deb: pkg/deb libmsgxchng-docker
	docker run --rm nanobox/fpm-cookery:libmsgxchng > pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_amd64.deb

PHONY: publish-libmsgxchng

publish-libmsgxchng: pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_amd64.deb
	aws s3 cp pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
	aws cloudfront create-invalidation --distribution-id ${CLOUDFRONT_DISTRIBUTION_ID} --paths deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_amd64.deb

publish-libmsgxchng-dryrun: pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_amd64.deb
	aws s3 cp pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --dryrun

PHONY: libmsgxchng-18.04-docker

libmsgxchng-18.04-docker: ubuntu-18.04
	docker build --build-arg LIBMSGXCHNG_VERSION=${LIBMSGXCHNG_VERSION} -t nanobox/fpm-cookery:libmsgxchng-18.04 -f libmsgxchng/Dockerfile-18.04 libmsgxchng

PHONY: libmsgxchng-18.04

libmsgxchng-18.04: pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_18.04_amd64.deb

pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_18.04_amd64.deb: pkg/deb libmsgxchng-18.04-docker
	docker run --rm nanobox/fpm-cookery:libmsgxchng-18.04 > pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_18.04_amd64.deb

PHONY: publish-libmsgxchng-18.04

publish-libmsgxchng-18.04: pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_18.04_amd64.deb
	aws s3 cp pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_18.04_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
	aws cloudfront create-invalidation --distribution-id ${CLOUDFRONT_DISTRIBUTION_ID} --paths deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_18.04_amd64.deb

publish-libmsgxchng-18.04-dryrun: pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_18.04_amd64.deb
	aws s3 cp pkg/deb/libmsgxchng_${LIBMSGXCHNG_VERSION}_18.04_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --dryrun

PHONY: red-docker

red-docker: ubuntu
	docker build --build-arg RED_VERSION=${RED_VERSION} --build-arg LIBBFRAME_VERSION=${LIBBFRAME_VERSION} --build-arg LIBMSGXCHNG_VERSION=${LIBMSGXCHNG_VERSION} -t nanobox/fpm-cookery:red red

PHONY: red

red: pkg/deb/red_${RED_VERSION}_amd64.deb

pkg/deb/red_${RED_VERSION}_amd64.deb: pkg/deb red-docker
	docker run --rm nanobox/fpm-cookery:red > pkg/deb/red_${RED_VERSION}_amd64.deb

PHONY: publish-red

publish-red: pkg/deb/red_${RED_VERSION}_amd64.deb
	aws s3 cp pkg/deb/red_${RED_VERSION}_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
	aws cloudfront create-invalidation --distribution-id ${CLOUDFRONT_DISTRIBUTION_ID} --paths deb/red_${RED_VERSION}_amd64.deb

publish-red-dryrun: pkg/deb/red_${RED_VERSION}_amd64.deb
	aws s3 cp pkg/deb/red_${RED_VERSION}_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --dryrun

PHONY: redd-docker

redd-docker: ubuntu
	docker build --build-arg REDD_VERSION=${REDD_VERSION} --build-arg LIBBFRAME_VERSION=${LIBBFRAME_VERSION} --build-arg LIBMSGXCHNG_VERSION=${LIBMSGXCHNG_VERSION} -t nanobox/fpm-cookery:redd redd

PHONY: redd

redd: pkg/deb/redd_${REDD_VERSION}_amd64.deb

pkg/deb/redd_${REDD_VERSION}_amd64.deb: pkg/deb redd-docker
	docker run --rm nanobox/fpm-cookery:redd > pkg/deb/redd_${REDD_VERSION}_amd64.deb

PHONY: publish-redd

publish-redd: pkg/deb/redd_${REDD_VERSION}_amd64.deb
	aws s3 cp pkg/deb/redd_${REDD_VERSION}_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
	aws cloudfront create-invalidation --distribution-id ${CLOUDFRONT_DISTRIBUTION_ID} --paths deb/redd_${REDD_VERSION}_amd64.deb

publish-redd-dryrun: pkg/deb/redd_${REDD_VERSION}_amd64.deb
	aws s3 cp pkg/deb/redd_${REDD_VERSION}_amd64.deb s3://${S3_BUCKET}/deb/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --dryrun