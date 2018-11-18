#!/bin/bash


source ~/.nvm/nvm.sh
export ARTIFACTS_HOME=`pwd`/artifacts/
mkdir -p $ARTIFACTS_HOME

pushd lergo-ri
   nvm use
popd

set -e

echo $CI_BUILD_ID > build.id

export BUILD_NUMBER=${CI_BUILD_ID:-local-build-id};
export JOB_NAME=${CI_JOB_NAME:-local-job-name};

\cp -f lergo-ri/dist/*.tgz $ARTIFACTS_HOME
\cp -f lergo-ui/dist/*.tgz $ARTIFACTS_HOME
\cp -f build.id $ARTIFACTS_HOME
\cp -f lergo-ri/build/install.sh $ARTIFACTS_HOME


pushd lergo-ri/build/vagrant/synced_folder/tasks
ls -ll $ARTIFACTS_HOME
echo $AWS_ACCESS_KEY_ID
  grunt s3:uploadArtifacts
  grunt s3:uploadArtifactsLatest
popd
