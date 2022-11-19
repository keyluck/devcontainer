#!/bin/bash
RED='\033[0;31m'
LBLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

verify_tools() {
  tools=("aws" "aws-vault" "chamber" "java" "gpg" "kubectl" "kubectl krew" "git-mob" "pre-commit" "python")

  for t in "${tools[@]}"; do
    exit_code="$($t --help >/dev/null 2>&1;echo $?)"
    if [ "$exit_code" == 0 ]; then
      echo -e "${LBLUE}${t}${NC} ${GREEN}successfully${NC} installed."
    else
      echo -e "${RED}Warning${NC} - ${LBLUE}${t}${NC} is missing!"
    fi
  done
}

setup_kube(){
  echo -e "\nSetting up Kubernetes...\n"
  export GPG_TTY=$(tty)
  aws-vault exec ldx.pipeline --no-session -- /workspaces/lighthouse-di-documentation/maintainers/scripts/onboarding/kubernetes-setup.sh
}

verify_tools
setup_kube