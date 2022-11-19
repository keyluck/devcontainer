#!/bin/bash
set -e

lhdidirectory="/workspaces"
id="github.com"
pwd=$(pwd)

sed "s/githubsshkeyid/${id}/g" "$(find . -maxdepth 1 -name mrconfig)" > "${lhdidirectory}/.mrconfig"
cd "/workspaces"
mr checkout
echo -n "Installing pre-commit hooks at commit, commit-msg, prepare-commit-msg, pre-push..."
mr --quiet run command pre-commit install && echo -n "..."
mr --quiet run command pre-commit install --hook-type commit-msg && echo -n "..."
mr --quiet run command pre-commit install --hook-type prepare-commit-msg && echo -n "..."
mr --quiet run command pre-commit install --hook-type pre-push && echo -n "..."
echo "Done!"

echo "Setting global pull.rebase config to true"
git config --global pull.rebase true
cd "${pwd}"
