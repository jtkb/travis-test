#!/usr/bin/env bash

export PROJECT_VERSION=$(mvn help:evaluate -Dexpression=project.version | grep -v ^\\[INFO\\])
echo "PROJECT_VERSION = ${PROJECT_VERSION}"
export IS_RELEASE=$(echo ${PROJECT_VERSION} | grep \\-SNAPSHOT$ | echo $?)
echo "IS_RELEASE = ${IS_RELEASE}"
export TRUE=1
export FALSE=0
if [ "${TRAVIS_PULL_REQUEST}" == 'false' ]; then
    export IS_PR=${FALSE}
else
    export IS_PR=${TRUE}
fi