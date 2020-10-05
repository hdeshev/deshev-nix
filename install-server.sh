#!/bin/sh

curl -L --proto '=https' --tlsv1.2 https://nixos.org/nix/install | sh

sed -i '/Nix env start/,/Nix env end/d' ~/.bashrc
echo '
# Nix env start
alias g='git'
. $HOME/.nix-profile/etc/profile.d/nix.sh
. setup-nix-env
eval "$(starship init bash)"
# Nix env end
' >> ~/.bashrc

. "$HOME/.nix-profile/etc/profile.d/nix.sh"
nix-channel --add https://nixos.org/channels/nixos-20.03 nixpkgs
nix-channel --update

nix-env -f ./server-env.nix -i
dotfiles
