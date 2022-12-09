#!/bin/bash
DEV_C_ROOT="/workspaces/devcontainer/.devcontainer"

install_krew() {
  export PATH="/home/codespace/.krew/bin:$PATH"
  kubectl krew install get-all
  kubectl krew install konfig
  kubectl krew install ctx
  rm $HOME/.krew/bin/*
  ln -s $HOME/.krew/store/get-all/v*/get-all-amd64-linux $HOME/.krew/bin/kubectl-get_all
  ln -s $HOME/.krew/store/konfig/v*/konfig-krew $HOME/.krew/bin/kubectl-konfig
  ln -s $HOME/.krew/store/krew/v*/krew $HOME/.krew/bin/kubectl-krew
  ln -s $HOME/.krew/store/ctx/v*/krew $HOME/.krew/bin/kubectl-ctx
  
}

init() {
  sudo apt-get update && sudo update-ca-certificates 
  sudo apt-get install -y pass dnsutils iputils-ping
 
  sudo cp -r /root/.krew $HOME
  sudo chown -R 1000:1000 $HOME/.krew
  # Recreate symlinks to point to new path
  install_krew
  
  cp -r ${DEV_C_ROOT}/configs/. $HOME
  envsubst < /workspaces/devcontainer/.devcontainer/configs/.aws/credentials > $HOME/.aws/credentials
  
  pass init -p aws-vault 202AFBD04D86E910
  sudo chmod 600 ~/.ssh/id_ed*
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519

  go install github.com/rhysd/actionlint/cmd/actionlint@latest

  git config --global push.autoSetupRemote true
}



init

