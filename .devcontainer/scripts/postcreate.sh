#!/bin/bash

DEV_C_ROOT="/workspaces/devcontainer/.devcontainer"
RED='\033[0;31m'
LBLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

init_setup() {
  sudo rm -rf ~/.{gnupg,kube,aws}
  sudo cp -r ${DEV_C_ROOT}/configs/. $HOME
  sudo chown -R codespace:codespace ~/.{gnupg,aws,password-store,ssh}
  find $HOME/.gnupg -type f -exec sudo chmod 600 {} \; # Set 600 for files
  find $HOME/.gnupg -type d -exec sudo chmod 700 {} \; # Set 700 for directories
  pass init -p aws-vault 202AFBD04D86E910
  sudo chmod 600 ~/.ssh/id_ed*
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  export GPG_TTY=$(tty)
  # setup_aws

  git config --global push.autoSetupRemote true
}

init_setup