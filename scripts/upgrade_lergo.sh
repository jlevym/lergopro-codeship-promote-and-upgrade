#!/bin/bash
set -e


hash='#';
# export BUILD_NUMBER=${CI_BUILD_ID:-local-build-id};
export BUILD_NUMBER=${CI_STRING_TIME:-local-build-id};
export BUILD_ID=${CI_STRING_TIME:-local-build-id};
# export BUILD_DISPLAY_NAME=$hash${CI_BUILD_ID:-local-build-id};
export BUILD_DISPLAY_NAME=$hash${CI_COMMIT_ID:-local-build-id};
# export JOB_NAME=${CI_JOB_NAME:-local-job-name};
export BUILD_TAG=CI Build;



echo 'CI string time' $CI_STRING_TIME
# echo "Build Number : $BUILD_NUMBER <br/> Build ID : $BUILD_ID <br/> Build Name : $BUILD_DISPLAY_NAME <br/> Job Name : $JOB_NAME <br/> Build Tag : $BUILD_TAG <br/>" > $VERSION_TEMPLATE


pushd lergo-ri
    source ~/.nvm/nvm.sh
    nvm install
    npm install
popd

set -e

echo $CI_BUILD_ID > build.id

echo pwd

pushd lergo-ri

echo 'decrypting lergopro pem'
source build/decrypt_lergopro_pm.sh

echo 'this is lergopro pem'
cat conf/dev/lergopro.pem


popd



