
#!/bin/bash
set -e
echo install lergo-ui
cd lergo-ui
source ~/.nvm/nvm.sh
nvm install
npm install
npm install aws-cli

build_id=5

echo check if build number,  $build_id  is an integer
if [[ ! "$build_id" =~ ^[0-9]+$ ]]; then 
  exit 1
fi


BUILD_ID_URL="https://s3-eu-west-1.amazonaws.com/lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/build.id"

INSTALL_SH_URL="https://s3-eu-west-1.amazonaws.com/lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/install.sh"

LERGO_RI_URL="https://s3-eu-west-1.amazonaws.com/lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/lergo-ri-0.0.0.tgz"

LERGO_UI_URL="https://s3-eu-west-1.amazonaws.com/lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/lergo-ui-0.0.0.tgz"


aws s3 cp s3://lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/build.id s3://lergopro-backups/artifacts/build-lergopro-3/jobs/build-lergopro/3/build.id
aws s3 cp s3://lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/install.sh s3://lergopro-backups/artifacts/build-lergopro-3/jobs/build-lergopro/3/install.sh
aws s3 cp s3://lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/lergo-ri-0.0.0.tgz s3://lergopro-backups/artifacts/build-lergopro-3/jobs/build-lergopro/3/lergo-ri-0.0.0.tgz
aws s3 cp s3://lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/lergo-ui-0.0.0.tgz s3://lergopro-backups/artifacts/build-lergopro-3/jobs/build-lergopro/3/lergo-ui-0.0.0.tgz


# changing bucket name to lergopro-backups
sed -i 's/lergo-backups/lergopro-backups/g' Gruntfile.js
sed -i 's/process.env.JOB_NAME/"build-lergopro"/g' Gruntfile.js

  # grunt s3:uploadArtifacts
  # grunt s3:uploadArtifactsLatest

echo upload completed succesfully
