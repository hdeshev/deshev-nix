{ gui-wrapper, slack }:
gui-wrapper "slack" ''
  gui-env ${slack}/bin/slack "$@"
''
