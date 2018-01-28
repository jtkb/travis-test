#!/usr/bin/env bash

if [ "$TRAVIS_BRANCH" = 'master' ] && [ ${IS_RELEASE} -eq ${TRUE} ] && [ ${IS_PR} -eq ${FALSE} ]; then
    echo "Building MASTER for release"
    mvn clean deploy -Prelease --settings travis/travissettings.xml
elif [ "$TRAVIS_BRANCH" = 'dev' ] && [ ${IS_RELEASE} -eq ${FALSE} ] && [ ${IS_PR} -eq ${FALSE} ]; then
    echo "Building DEV for SNAPSHOT"
    mvn clean deploy -Prelease --settings travis/travissettings.xml
else
    echo "Doing plain build."
    mvn clean install
fi