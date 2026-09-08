# jira-cli (ankitpokhrel/jira-cli) — packaged in nixpkgs as jira-cli-go.
#
# Auth uses an API token via env var:
#   export JIRA_API_TOKEN="<your-token>"
# Create one at: https://id.atlassian.com/manage-profile/security
#
# Config lives at ~/.config/.jira/.config.yml and is managed outside Home
# Manager. Generate it with `jira init`.
{ config, pkgs, ... }:
{
  home.packages = [ pkgs.jira-cli-go ];
}
