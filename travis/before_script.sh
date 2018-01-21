#!/usr/bin/env bash
# if [ "$TRAVIS_BRANCH" = 'master' ] && [ "$TRAVIS_PULL_REQUEST" == 'false' ]; then
if [ "$TRAVIS_BRANCH" = 'dev' ]; then
    mkdir ~/.m2
    cp ${TRAVIS_BUILD_DIR}/travis/settings-security.xml ~/.m2/

    openssl aes-256-cbc -K $encrypted_4f3061b44f4c_key -iv $encrypted_4f3061b44f4c_iv -in ${TRAVIS_BUILD_DIR}/travis/encrypt-settings.xml.enc -out ${TRAVIS_BUILD_DIR}/travis/encrypt-settings.xml -d

    openssl aes-256-cbc -K $encrypted_6546a769d586_key -iv $encrypted_6546a769d586_iv -in ${TRAVIS_BUILD_DIR}/travis/codesigning.asc.enc -out ${TRAVIS_BUILD_DIR}/travis/codesigning.asc -d
    gpg --fast-import ${TRAVIS_BUILD_DIR}/travis/codesigning.asc
fi