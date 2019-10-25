#!/bin/bash

set -eou pipefail

SCRIPT_PATH=$(readlink -f $BASH_SOURCE)
PROJECT_DIR=$(dirname $SCRIPT_PATH)

nix-env -f "$PROJECT_DIR" -i
dotfiles
