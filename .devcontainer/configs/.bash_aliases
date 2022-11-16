#!/bin/bash
alias av=aws-vault
alias ku=kubectl
alias kz='kubectl kustomize'
alias tf=terraform
alias lc=linode-cli
alias changens='kubectl config set-context --current --namespace '
alias argocdpass='kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d'