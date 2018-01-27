#!/usr/bin/env bash

echo "TRAVIS_BRANCH = ${TRAVIS_BRANCH}"
echo "TRAVIS_PULL_REQUEST = ${TRAVIS_PULL_REQUEST}"

export PROJECT_VERSION=$(mvn help:evaluate -Dexpression=project.version | grep ^1\.0\.0-SNAPSHOT)
# export PROJECT_VERSION=$(mvn help:evaluate -Dexpression=project.version | tee >(grep -v ^\\[INFO\\]) &>/dev/null)
#mvn help:evaluate -Dexpression=project.version > version.file
#cat version.file | grep -v ^\\[INFO\\] | grep -v ^Down > version.reduced
#cat version.reduced
#export PROJECT_VERSION=$(cat version.reduced)
#export PROJECT_VERSION=$(cat version.file > /dev/null)
#export PROJECT_VERSION=`cat version.file | grep -v ^\\[INFO\\]`
#rm -f version.*
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

echo "Before_script complete"

## Test if merge to master that it is not still in SNAPSHOT
#if [ "$TRAVIS_BRANCH" = 'master' ] && [ "$TRAVIS_PULL_REQUEST" != 'false' ]; then
#    # PROJECT_VERSION=$(mvn help:evaluate -Dexpression=project.version | grep -v ^\\[INFO\\])
#    echo "Project Version: ${PROJECT_VERSION}"
#    echo ${PROJECT_VERSION} | grep \\-SNAPSHOT$
#    if [ $? -eq 0 ]; then
#        # version ends with -SNAPSHOT
#        echo "The version ends with -SNAPSHOT."
#        exit 1
#    fi
#fi
#
#if [ "$TRAVIS_BRANCH" = 'dev' ] && [ ${IS_RELEASE} -eq ${FALSE} ] ; then
#    echo "This is a SNAPSHOT build"
#    mkdir ~/.m2
#    cp ${TRAVIS_BUILD_DIR}/travis/settings-security.xml ~/.m2/
#
#    openssl aes-256-cbc -K $encrypted_4f3061b44f4c_key -iv $encrypted_4f3061b44f4c_iv -in ${TRAVIS_BUILD_DIR}/travis/encrypt-settings.xml.enc -out ${TRAVIS_BUILD_DIR}/travis/encrypt-settings.xml -d
#
#    openssl aes-256-cbc -K $encrypted_6546a769d586_key -iv $encrypted_6546a769d586_iv -in ${TRAVIS_BUILD_DIR}/travis/codesigning.asc.enc -out ${TRAVIS_BUILD_DIR}/travis/codesigning.asc -d
#    gpg --fast-import --no-tty ${TRAVIS_BUILD_DIR}/travis/codesigning.asc &> /dev/null
#fi
#
#if [ "$TRAVIS_BRANCH" = 'master' ] && [ ${IS_RELEASE} -eq ${TRUE} ] ; then
#    echo "This is a release build"
#    mkdir ~/.m2
#    cp ${TRAVIS_BUILD_DIR}/travis/settings-security.xml ~/.m2/
#
#    openssl aes-256-cbc -K $encrypted_4f3061b44f4c_key -iv $encrypted_4f3061b44f4c_iv -in ${TRAVIS_BUILD_DIR}/travis/encrypt-settings.xml.enc -out ${TRAVIS_BUILD_DIR}/travis/encrypt-settings.xml -d
#
#    openssl aes-256-cbc -K $encrypted_6546a769d586_key -iv $encrypted_6546a769d586_iv -in ${TRAVIS_BUILD_DIR}/travis/codesigning.asc.enc -out ${TRAVIS_BUILD_DIR}/travis/codesigning.asc -d
#    gpg --fast-import --no-tty ${TRAVIS_BUILD_DIR}/travis/codesigning.asc &> /dev/null
#fi
# TODO: Remove to enable build to proceed.
#exit 1