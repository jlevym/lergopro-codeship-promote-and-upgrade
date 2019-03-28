
#!/bin/bash
set -e

# build_id is the build that will be promoted and must be set before each use!
build_id=6
echo promoting build number ${build_id}

echo cd into lergo-ri to install node and npm
cd lergo-ri
source ~/.nvm/nvm.sh
nvm install

echo cd away from package.json to prevent long unecessary npm install
cd ..
npm install

echo install aws-cli
npm install aws-cli


echo check that build number,  $build_id  is an integer
if [[ ! "$build_id" =~ ^[0-9]+$ ]]; then 
  exit 1
fi
echo copying files in S3 from ${build_id} to 'latest'

aws s3 cp s3://lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/build.id s3://lergopro-backups/artifacts/latest/build.id
aws s3 cp s3://lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/install.sh s3://lergopro-backups/artifacts/latest/install.sh
aws s3 cp s3://lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/lergo-ri-0.0.0.tgz s3://lergopro-backups/artifacts/latest/lergo-ri-0.0.0.tgz
aws s3 cp s3://lergopro-backups/artifacts/build-lergopro-${build_id}/jobs/build-lergopro/${build_id}/lergo-ui-0.0.0.tgz s3://lergopro-backups/artifacts/latest/lergo-ui-0.0.0.tgz


echo promote completed succesfully
