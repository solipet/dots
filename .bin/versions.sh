#! /bin/bash

function check_version(){
  echo "${system} (${env}):"
  curl https://${host}/${path}
  echo
}

system='HUBZone Map'
path='hubzone/map/version.json'

env=dev
host=hubzone.dev.sba-one.net
check_version

env=demo
host=hubzone.demo.sba-one.net
check_version

env=qa
host=hubzone.qa.sba-one.net
check_version

system='HUBZone API'
path='api/version.json'

env=dev
host=hubzone.dev.sba-one.net
check_version

env=demo
host=hubzone.demo.sba-one.net
check_version

env=qa
host=hubzone.qa.sba-one.net
check_version

system='HUBZone Report'
path='report/version.json'

env=dev
host=hubzone.dev.sba-one.net
check_version

env=demo
host=hubzone.demo.sba-one.net
check_version

env=qa
host=hubzone.qa.sba-one.net
check_version

system='Message API'
path='msg/version.json'

env=dev
host=msg.${env}.sba-one.net
check_version

env=demo
host=msg.${env}.sba-one.net
check_version

env=qa
host=msg.${env}.sba-one.net
check_version

system='Notification API'
path='notify/version.json'

env=dev
host=notify.${env}.sba-one.net
check_version

env=demo
host=notify.${env}.sba-one.net
check_version

env=qa
host=notify.${env}.sba-one.net
check_version

system='Activity API'
path='activity_log/version.json'

env=dev
host=activity.${env}.sba-one.net
check_version

env=demo
host=activity.${env}.sba-one.net
check_version

env=qa
host=activity.${env}.sba-one.net
check_version

system='SBA-IDP'
path='sba_idp/version.json'

env=dev
host=sba-idp.${env}.sba-one.net
check_version

env=demo
host=sba-idp.${env}.sba-one.net
check_version

env=qa
host=sba-idp.${env}.sba-one.net
check_version

system='Business API'
path='business_api/version.json'

env=dev
host=business.${env}.sba-one.net
check_version

env=demo
host=business.${env}.sba-one.net
check_version

env=qa
host=business.${env}.sba-one.net
check_version
