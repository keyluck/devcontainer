#!/bin/bash
set -e

directory="${1}"
lhdidirectory="${directory}"/lighthouse-di
id="github.com"
pwd=$(pwd)

sed "s/githubsshkeyid/${id}/g" "$(find . -name mrconfig)" > "${lhdidirectory}/.mrconfig"
cd "${lhdidirectory}"
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
