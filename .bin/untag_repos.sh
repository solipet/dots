#! /bin/sh

# Don't do git pre-push hook
export SKIP_PRE_PUSH=true

function tag_usage(){
  echo "Usage: $0 <sprint_number>"
  exit 1
}

function tag_repo(){
  echo "----------- ${REPO} ------ Sprint ${SPRINT} ---------------------"
  cd "${WORK}/${REPO}"
  git tag -d "${TAG}-${SPRINT}"
  git push --delete origin ${TAG}-${SPRINT}
}

if [ $# -ne 1 ]; then
  tag_usage
fi

SPRINT=$1
echo "Tagging sprint $SPRINT"

MESSAGE="HUBZone Sprint"
TAG="hubzone-sprint"
#declare -a REPOS=(hzm hzapi hubzone-report hzetl)
declare -a REPOS=(hubzone-report hzetl)
for r in ${REPOS[@]}
do
  BRANCH=develop
  REPO=$r
  tag_repo
done

BRANCH=master
REPO=hubzone-geoserver-config
tag_repo


MESSAGE="Shared Services Sprint"
TAG="shared-services-sprint"
declare -a REPOS=(message-api certify_messages notification-api certify_notifications activity-api certify_activity_log shared-services-prototype sba-idp omniauth-login-gov)
for r in ${REPOS[@]}
do
  BRANCH=develop
  REPO=$r
  tag_repo
done

unset SKIP_PRE_PUSH
