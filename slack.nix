{ gui-wrapper, slack }:
gui-wrapper "slack" ''
  gui-exec ${slack}/bin/slack "$@"
''
