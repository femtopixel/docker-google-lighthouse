#!/usr/bin/env bash
#
# Build and push an image to ECR.
#

if [ ! -z "${VERBOSE}" ]; then
    set -x
fi

set -e

: ${APP_NAME=docker-google-lighthouse}
: ${EC2_REGION=us-east-1}
# Login to ECR
$(aws ecr get-login --no-include-email --region ${EC2_REGION})
: ${ECR_REPO=291053455966.dkr.ecr.${EC2_REGION}.amazonaws.com/${APP_NAME}}

REPO_NAME=$(git for-each-ref --format='%(upstream:short)' `git symbolic-ref -q HEAD` | awk -F/ '{print $1}' )

if [ -z "${REPO_NAME}" ]; then
    echo "There seems to be no tracking information for the current branch."
    echo "If this is a new branch - push it to a remote and set with:"
    echo "    git branch --set-upstream-to=<remote>/<branch> <branch>"
    exit 1
fi

REPO=$(git remote get-url ${REPO_NAME} | sed -e 's/.*:\(.*\)\/.*/\1/;' )
SHA=$(git rev-parse --short HEAD | tee REVISION)

# Enable BuildKit support. This requires a modern (>18.06) Docker.
export DOCKER_BUILDKIT=1

# build image
docker build --ssh default . -t ${APP_NAME}:latest -t ${APP_NAME}:${REPO}-${SHA}

# push image
docker tag ${APP_NAME}:${REPO}-${SHA} ${ECR_REPO}:${REPO}-${SHA}
docker push ${ECR_REPO}:${REPO}-${SHA}
