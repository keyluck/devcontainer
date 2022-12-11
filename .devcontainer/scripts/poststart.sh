#!/bin/bash

DEV_C_ROOT="/workspaces/devcontainer/.devcontainer"
RED='\033[0;31m'
LBLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

init_setup() {
  cp -r ${DEV_C_ROOT}/configs/. $HOME
  envsubst < /workspaces/devcontainer/.devcontainer/configs/.aws/credentials > $HOME/.aws/credentials
  
  pass init -p aws-vault 202AFBD04D86E910
  sudo chmod 600 ~/.ssh/id_ed*
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519

  git config --global push.autoSetupRemote true
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
  export GPG_TTY=$(tty)
  aws-vault exec ldx.pipeline --no-session -- /workspaces/lighthouse-di-documentation/maintainers/scripts/onboarding/kubernetes-setup.sh
}

init_setup
verify_tools
setup_kube