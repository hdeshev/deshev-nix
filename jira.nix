# go-jira CLI — built from master (748b7d5) which includes the v3 search
# API fix (PR #512). The nixpkgs v1.0.28 tag predates the fix.
#
# Auth uses an API token via env var:
#   export JIRA_API_TOKEN="<your-token>"
# Create one at: https://id.atlassian.com/manage-profile/security
{ config, pkgs, ... }:
let
  go-jira-fixed = pkgs.go-jira.overrideAttrs (finalAttrs: previousAttrs: {
    version = "1.0.29-unstable-2025-11-11";

    src = pkgs.fetchFromGitHub {
      owner = "go-jira";
      repo = "jira";
      rev = "748b7d552f8b3ad993b05810b93f0f2ed39822d1";
      sha256 = "sha256-PFmgnGGayrgcC46UvvSzCQ1uVc87H1kgWBdMrcCRZD4=";
    };

    vendorHash = "sha256-r69aFl3GwgZ1Zr4cEy4oWlqsrjNCrqjwW9BU9+d8xDQ=";
  });
in
{
  home.packages = [ go-jira-fixed ];

# Example ~/.jira.d/config.yml (managed outside Home Manager):
#   endpoint: https://yourcompany.atlassian.net
#   user: you@yourcompany.com
#   login: you@yourcompany.com   # only if login email differs from Jira username
}
