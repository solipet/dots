#! /bin/sh

OLD_ACCT='SBA-ONE'
NEW_ACCT='USSBA'
SED_CMD="s/${OLD_ACCT}/${NEW_ACCT}/"

for dir in `find . -name .git -type d`
do
  echo "${dir}/config"
  sed -i '.bak' $SED_CMD "${dir}/config"
done
