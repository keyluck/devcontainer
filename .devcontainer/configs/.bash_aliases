#!/bin/bash

alias fix-gpg='pkill -9 gpg-agent && export GPG_TTY=$(tty)'
alias ku=kubectl
alias ku.ctx='kubectl ctx'
alias ku.ns='kubectl config set-context --current --namespace'
alias kz='kubectl kustomize'
alias tf=terraform
alias lc=linode-cli
alias changens='kubectl config set-context --current --namespace '
alias argocdpass='kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d'