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

cd lergo-ri
echo 'pwd:'
pwd
echo 'TESTME_KEY' $TESTME_KEY

echo 'creating file conf/dev/lergopro.pem'
mkdir conf/dev && touch conf/dev/lergopro.pem

echo 'decrypting lergopro pem'

source build/decrypt_lergopro_pem.sh
mkdir ~/.ssh && touch ~/.ssh/known_hosts
ssh-keyscan -H 52.211.75.196 >> ~/.ssh/known_hosts
export KEY_FILE=conf/dev/lergopro.pem

chmod 600 $KEY_FILE
ssh -i $KEY_FILE ubuntu@52.211.75.196 -v << EOF
echo 'inside lergo'
sudo service lergo upgrade && sudo service lergo stop && sudo service lergo start
sudo service lergo status
exit
EOF




