FROM ghcr.io/department-of-veterans-affairs/lighthouse-developer-portal/devcontainer:latest

USER root
ENV GITCONFIG="/etc/gitconfig"
ENV BREW="/home/linuxbrew/.linuxbrew/bin"
ENV KREW="/home/codespaces/.krew/bin"
ENV PATH="$GITCONFIG:$BREW:$KREW:$PATH"
COPY --chmod=1000:1000 ~/{.,}* ~/
COPY --chmod=1000:1000 configs/gitconfig /etc/gitconfig
COPY --chmod=1000:1000 configs/.bash_aliases ~/.bash_aliases
COPY --chmod=1000:1000 scripts/* /tmp/scripts/

RUN cat ~/.env >> /etc/environment \
  && mv ~/.ssh_devcontainer ~/.ssh \
  && source /etc/environment \
  && update-ca-certificates \
  && /bin/bash -c "$(echo -ne '\n' | curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
  && brew install aws-vault \
  && bash /tmp/scripts/krew.sh \
  && npm install -g git-mob \
  && go install github.com/segmentio/chamber/v2@latest \
  && mkdir /workspaces/devcontainer/repos \
  && bash /tmp/scripts/repos.sh "/workspaces/devcontainer/repos"

