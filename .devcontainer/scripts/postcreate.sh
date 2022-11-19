#!/bin/bash
DEV_C_ROOT="/workspaces/devcontainer/.devcontainer"

init() {
  sudo apt-get install -y pass
  sudo update-ca-certificates
  cp -r ${DEV_C_ROOT}/configs/. $HOME
  pass init -p aws-vault 202AFBD04D86E910
  sudo chmod 600 ~/.ssh/id_ed*
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
}

install_krew() {
  export PATH="/home/codespace/.krew/bin:$PATH"
  kubectl krew install get-all
  kubectl krew install konfig
}

init
install_krew
