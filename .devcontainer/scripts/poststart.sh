#!/bin/bash

DEV_C_ROOT="/workspaces/devcontainer/.devcontainer"
RED='\033[0;31m'
LBLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

setup_aws() {
  export GPG_TTY=$(tty)
  echo 'Yes' | /workspaces/lighthouse-di-documentation/maintainers/scripts/onboarding/aws-setup.sh
  # export AWS_SECRET_ACCESS_KEY=$(pass aws-vault/AWS_SECRET_ACCESS_KEY)
  # export AWS_ACCESS_KEY_ID=$(pass aws-vault/AWS_ACCESS_KEY_ID)
  aws configure set aws_access_key_id $(pass aws-vault/AWS_SECRET_ACCESS_KEY)
  aws configure set aws_secret_access_key $(pass aws-vault/AWS_ACCESS_KEY_ID)
  # aws configure set aws_access_key_id $(chamber read project/project-ldx/teams/lhdi/platform/env/ldx-dev/ldx-service-account-2 aws_access_key_id -q) 
  # aws configure set aws_secret_access_key $(chamber read project/project-ldx/teams/lhdi/platform/env/ldx-dev/ldx-service-account-2 aws_secret_access_key -q) 
}

verify_tools() {
  tools=("aws" "aws-vault" "chamber" "docker" "go" "gpg" "java" "kubectl" "kubectl krew" "git-mob" "pre-commit" "python3" "ruby")

  for t in "${tools[@]}"; do
    cmd="$t --help"
    if [ "$t" == "go" ]; then cmd="$t help"; fi
    exit_code="$($cmd >/dev/null 2>&1;echo $?)"
    if [ "$exit_code" == 0 ]; then
      echo -e "${LBLUE}${t}${NC} ${GREEN}successfully${NC} installed."
    else
      echo -e "${RED}Warning${NC} - ${LBLUE}${t}${NC} is missing!"
    fi
  done
}

setup_kube(){
  echo -e "\nSetting up Kubernetes...\n"
  aws-vault exec ldx.pipeline --no-session -- /workspaces/lighthouse-di-documentation/maintainers/scripts/onboarding/kubernetes-setup.sh
  sudo chmod -R 0777 ~/.kube
}

setup_aws
verify_tools
setup_kube