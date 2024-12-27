#!/bin/sh
set -xe

#Build and push image

#Login to registry
docker login -u gitlab-ci-token -p $CI_JOB_TOKEN $CI_REGISTRY

#cp -r ${CONFIG_PATH}/* .;

#cd AKC.MobileAPI
docker build -t ${CONTAINER_RELEASE_IMAGE} -f Dockerfile .
docker push ${CONTAINER_RELEASE_IMAGE}
 
#docker remove image to registry
docker rmi ${CONTAINER_RELEASE_IMAGE}
