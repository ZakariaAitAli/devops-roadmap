#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

if [ -f "$ENV_FILE" ]; then
  # shellcheck source=/dev/null
  source "$ENV_FILE"
fi

USER=${DEPLOY_USER:-ec2-user}
HOST=${DEPLOY_HOST:?Error: DEPLOY_HOST is not set. Create a .env file or export DEPLOY_HOST.}
KEY=${DEPLOY_KEY:-~/.ssh/id_rsa}
SOURCE=${DEPLOY_SOURCE:-./static-site/}
TARGET=${DEPLOY_TARGET:-/var/www/static-site/}

rsync -avz -e "ssh -i $KEY" "$SOURCE" "$USER@$HOST:$TARGET"
