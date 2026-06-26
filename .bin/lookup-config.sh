#! /bin/bash

function lookup_config_usage(){
  echo "Usage: $0 <config variable>"
  exit 1
}

function lookup_config(){
  echo -n "${ENV}: "
  aws-vault exec ${AWS_ENV_ROLE} -- bin/app-s3-secret --env ${ENV} --app idp | grep ${CONFIG_VARIABLE}
}

if [ $# -ne 1 ]; then
  lookup_config_usage
fi

CONFIG_VARIABLE=$1

AWS_ENV_ROLE=sandbox-power
declare -a AWS_ENVS=(solipet charity evelyn dev int)
for env in ${AWS_ENVS[@]}
do
  ENV=$env
  lookup_config
done

AWS_ENV_ROLE=prod-power
declare -a AWS_ENVS=(staging prod)
for env in ${AWS_ENVS[@]}
do
  ENV=$env
  lookup_config
done
