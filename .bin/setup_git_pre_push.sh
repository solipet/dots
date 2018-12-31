#! /bin/sh


WORK_DIR=/Users/doug/Documents/Fearless/dev

function set_pre_push() {
  for repo in "${repos[@]}"; do
    hook=${WORK_DIR}/${repo}/.git/hooks/pre-push
    echo "updating ${hook}"
    echo $message > ${hook}
    cat <<- _PRE_PULL_HUBZONE_ > ${hook}
			#!/bin/sh

			if [[ "\$SKIP_PRE_PUSH" = "true" ]]; then
			  exit 0
			fi

			echo "\n*Acceptance Checklist*
			${checklist}"

			# echo "\n*RSpec* (takes too long!)"
			# rspec -f d

			echo "\n*Rubocop*"
			rubocop -D
			res=\$?
			echo

			exit \${res}
_PRE_PULL_HUBZONE_
    chmod +x $hook
  done
}

# ---------- HUBZone Map/API/Report ------------------------
checklist='\
☐ run all tests: rspec, rubocop, js and linter tests as appropriate
☐ version increment
☐ README update as appropriate
☐ CHANGELOG update as appropriate
☐ Branch is synced with latest {{develop}}\
'
repos=('hzm' 'hzapi' 'hubzone-report')
set_pre_push

# ---------- Geoserver Config ------------------------------
checklist='\
☐ README update as appropriate
☐ CHANGELOG update as appropriate
☐ Branch is synced with latest {{master}}\
'
repos=('hubzone-geoserver-config')
set_pre_push

# ---------- HUBZone ETL -----------------------------------
checklist='\
☐ run all tests: rspec, rubocop
☐ README update as appropriate
☐ CHANGELOG update as appropriate
☐ Instructions in CHANGELOG for deploying ETL
☐ Branch is synced with latest {{develop}}\
'
repos=('hzetl')
set_pre_push

# ---------- Shared Services APIs --------------------------
checklist='\
☐ run all tests: rspec, rubocop, js and linter tests as appropriate
☐ version increment
☐ README & CHANGELOG update as appropriate
☐ updating type config markdown for certify APIs (rake ss:config_to_md)
☐ Branch is synced with latest {{develop}}\
'
repos=('message-api' 'notification-api' 'activity-api')
set_pre_push

# ---------- Shared Services Gems --------------------------
checklist='\
☐ run all tests: rspec, rubocop, js and linter tests as appropriate
☐ version increment
☐ README & CHANGELOG update as appropriate
☐ Branch is synced with latest {{develop}}\
'
repos=('certify_messages' 'certify_notifications' 'certify_activity_log')
set_pre_push

