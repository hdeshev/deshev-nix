# Run command in an ssh-agent context
# Avoid multiple ssh key passphrase prompts (Prompts only once on `ssh-add`.)
{ writeShellScriptBin }:
[
  (writeShellScriptBin "ssh-ag" ''
    command="$@"
    ssh-agent bash -c "ssh-add ~/.ssh/id_rsa ~/.ssh/hdeshev.pem && $command"
  '')

  (writeShellScriptBin "ssh-m2m" ''
    command="$@"
    ssh-agent bash -c "ssh-add ~/.ssh/m2m_id_ed25519 && $command"
  '')
]
