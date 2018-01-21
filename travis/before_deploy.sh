#!/usr/bin/env bash
# if [ "$TRAVIS_BRANCH" = 'master' ] && [ "$TRAVIS_PULL_REQUEST" == 'false' ]; then
if [ "$TRAVIS_BRANCH" = 'dev' ]; then
    openssl aes-256-cbc -K $encrypted_6546a769d586_key -iv $encrypted_6546a769d586_iv -in travis/codesigning.asc.enc -out travis/codesigning.asc -d
    gpg2 --fast-import travis/codesigning.asc
fi