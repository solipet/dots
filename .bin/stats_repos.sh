#! /bin/bash -l

function usage(){
  echo "Usage: $0"
  exit 1
}

function checkout_master(){
  echo "----------- ${REPO} ---------------------------"
  cd "${WORK}/${REPO}"
  git checkout master
  git pull
  bundle install | grep -v Using
  rubocop
  rake stats | tail -2
  cat coverage/.last_run.json
}

function checkout_develop(){
  echo "----------- ${REPO} ---------------------------"
  cd "${WORK}/${REPO}"
  git checkout develop
  git pull
  bundle install | grep -v Using
  rubocop
  rake stats | tail -2
  cat coverage/.last_run.json
}

if [ $# -ne 0 ]; then
  usage
fi

declare -a REPOS=(hzm hzapi hubzone-report hzetl )
for r in ${REPOS[@]}
do
  REPO=$r
  checkout_develop
done

REPO=hubzone-geoserver-config
checkout_master

REPO=omniauth-openid-connect
checkout_master

declare -a REPOS=(message-api certify_messages notification-api certify_notifications activity-api certify_activity_log shared-services-prototype sba-idp omniauth-sba-idp certify_user business-profile-api certify_business email-api certify_email doc-api certify_documents sba-app)
for r in ${REPOS[@]}
do
  REPO=$r
  checkout_develop
done
