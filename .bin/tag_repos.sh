#! /bin/bash -l

# Don't do git pre-push hook
export SKIP_PRE_PUSH=true

function tag_usage(){
  echo "Usage: $0 <sprint_number>"
  exit 1
}

function tag_repo(){
  echo "----------- ${REPO} ------ Sprint ${SPRINT} ---------------------"
  cd "${WORK}/${REPO}"
  # Don't do the checkout here -- do it via dev_repos.sh
  # git checkout ${BRANCH}
  git pull
  git tag -a -m "${MESSAGE} ${SPRINT}" "${TAG}-${SPRINT}"
  git push --tags
}

if [ $# -ne 1 ]; then
  tag_usage
fi

SPRINT=$1
echo "Tagging sprint $SPRINT"

MESSAGE="HUBZone Sprint"
TAG="hubzone-sprint"
declare -a REPOS=(hubzone-webmap hubzone-api hubzone-report hubzone-data-etl hubzone-geoserver-config hubzone-landing)
for r in ${REPOS[@]}
do
  REPO=$r
  tag_repo
done

MESSAGE="Shared Services Sprint"
TAG="shared-services-sprint"
declare -a REPOS=(message-api certify_messages notification-api certify_notifications activity-api certify_activity_log shared-services-prototype sba-idp omniauth-openid-connect omniauth-sba-idp certify_user business-profile-api certify_business email-api certify_email doc-api certify_documents program-api certify-application-overview notes-api)
for r in ${REPOS[@]}
do
  REPO=$r
  tag_repo
done

unset SKIP_PRE_PUSH
