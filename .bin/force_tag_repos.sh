#! /bin/sh

function tag_usage(){
  echo "Usage: $0 <sprint_number>"
  exit 1
}

function tag_repo(){
  echo "----------- ${REPO} ------ Sprint ${SPRINT} ---------------------"
  cd "${WORK}/${REPO}"
  git checkout develop
  git pull
  git tag -a -f -m "${MESSAGE} ${SPRINT}" "${TAG}-${SPRINT}"
  git push --force --tags
}

if [ $# -ne 1 ]; then
  tag_usage
fi

SPRINT=$1
echo "Tagging sprint $SPRINT"

# MESSAGE="HUBZone Sprint"
# TAG="hubzone-sprint"
# declare -a REPOS=(hzm hzapi hubzone-report hzetl)
# for r in ${REPOS[@]}
# do
#   REPO=$r
#   tag_repo
# done


MESSAGE="Shared Services Sprint"
TAG="shared-services-sprint"
declare -a REPOS=(message-api certify_messages notification-api certify_notifications activity-api certify_activity_log)
for r in ${REPOS[@]}
do
  REPO=$r
  tag_repo
done

echo "\n\n\nReady to tag shared-services-prototype (e.g., Gemfile updated?): \c"
read ready
REPO=shared-services-prototype
tag_repo
