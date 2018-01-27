#!/usr/bin/env bash

echo "TRAVIS_BRANCH = ${TRAVIS_BRANCH}"
echo "TRAVIS_PULL_REQUEST = ${TRAVIS_PULL_REQUEST}"

# Test if merge to master that it is not still in SNAPSHOT
if [ "$TRAVIS_BRANCH" = 'master' ] && [ "$TRAVIS_PULL_REQUEST" != 'false' ]; then
    PROJECT_VERSION=$(mvn help:evaluate -Dexpression=project.version | grep -v ^\\[INFO\\])
    echo "Project Version: ${PROJECT_VERSION}"
    echo ${PROJECT_VERSION} | grep \\-SNAPSHOT
    if [ $? -eq 0 ]; then
        # version ends with -SNAPSHOT
        echo "The version ends with -SNAPSHOT."
        exit 1
    fi
fi

if [ "$TRAVIS_BRANCH" = 'dev' ]; then
    mkdir ~/.m2
    cp ${TRAVIS_BUILD_DIR}/travis/settings-security.xml ~/.m2/

    openssl aes-256-cbc -K $encrypted_4f3061b44f4c_key -iv $encrypted_4f3061b44f4c_iv -in ${TRAVIS_BUILD_DIR}/travis/encrypt-settings.xml.enc -out ${TRAVIS_BUILD_DIR}/travis/encrypt-settings.xml -d

    openssl aes-256-cbc -K $encrypted_6546a769d586_key -iv $encrypted_6546a769d586_iv -in ${TRAVIS_BUILD_DIR}/travis/codesigning.asc.enc -out ${TRAVIS_BUILD_DIR}/travis/codesigning.asc -d
    gpg --fast-import --no-tty ${TRAVIS_BUILD_DIR}/travis/codesigning.asc &> /dev/null
fi

# TODO: Remove to enable build to proceed.
exit 1