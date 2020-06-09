#!/bin/sh

curl -L --proto '=https' --tlsv1.2 https://nixos.org/nix/install | sh

sed -i '/alias g=/d' ~/.bashrc
echo "alias g='git'" >> ~/.bashrc

sed -i '/profile.d\/nix.sh/d' ~/.bashrc
echo ". $HOME/.nix-profile/etc/profile.d/nix.sh" >> ~/.bashrc

sed -i '/setup-nix-env/d' ~/.bashrc
echo ". setup-nix-env" >> ~/.bashrc

. "$HOME/.nix-profile/etc/profile.d/nix.sh"
nix-channel --add https://nixos.org/channels/nixos-20.03 nixpkgs
nix-channel --update

nix-env -f ./server-env.nix -i
dotfiles
