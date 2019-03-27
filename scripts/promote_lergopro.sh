
#!/bin/bash
set -e
echo install node and npm
cd lergo-ui
source ~/.nvm/nvm.sh
nvm install
cd ..
npm install
echo install aws-cli
npm install aws-cli

build_id=5
echo promoting build number ${build_id}

echo check if build number,  $build_id  is an integer
if [[ ! "$build_id" =~ ^[0-9]+$ ]]; then 
  exit 1
fi

aws s3 cp s3://lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/build.id s3://lergopro-backups/artifacts/latest/build.id
aws s3 cp s3://lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/install.sh s3://lergopro-backups/artifacts/latest/install.sh
aws s3 cp s3://lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/lergo-ri-0.0.0.tgz s3://lergopro-backups/artifacts/latest/lergo-ri-0.0.0.tgz
aws s3 cp s3://lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/lergo-ui-0.0.0.tgz s3://lergopro-backups/artifacts/latest/lergo-ui-0.0.0.tgz


echo upload completed succesfully
