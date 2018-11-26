{ gui-wrapper, slack }:
gui-wrapper "slack" ''
  exec ${slack}/bin/slack $@
''
