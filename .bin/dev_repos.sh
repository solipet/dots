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
}

function checkout_develop(){
  echo "----------- ${REPO} ---------------------------"
  cd "${WORK}/${REPO}"
  git checkout develop
  git pull
  bundle install | grep -v Using
  rubocop
}

if [ $# -ne 0 ]; then
  usage
fi

declare -a REPOS=(hubzone-webmap hubzone-api hubzone-report hubzone-data-etl hubzone-geoserver-config hubzone-landing)
for r in ${REPOS[@]}
do
  REPO=$r
  checkout_develop
done

REPO=hubzone-geoserver-config
checkout_master

REPO=omniauth-openid-connect
checkout_master

declare -a REPOS=(message-api certify_messages notification-api certify_notifications activity-api certify_activity_log shared-services-prototype sba-idp omniauth-sba-idp certify_user business-profile-api certify_business email-api certify_email doc-api certify_documents program-api certify-application-overview notes-api)
for r in ${REPOS[@]}
do
  REPO=$r
  checkout_develop
done
