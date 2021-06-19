{ gui-run, writeText, writeShellScriptBin, bash, kbdd }:
rec {
  config = {
    name = ".config/i3/config";
    file = writeText "i3-config" (builtins.readFile ./i3-config);
  };

  if-installed-code = ''
      if_installed() {
          which $1 > /dev/null && \
              eval $@
      }
      '';

  i3-session-start = writeShellScriptBin "i3-session-start" ''
      ${gui-run.locale}
      ${if-installed-code}
      ${configure-input}/bin/configure-input

      ${bash}/bin/bash "$HOME/.fehbg"

      #per-window kbd layout selection
      if [ "$(pidof kbdd)" ]
      then
        echo "kbdd already running"
      else
        ${kbdd}/bin/kbdd
      fi

      "i3-session-$(hostname)"
      '';

  i3-session-lever = writeShellScriptBin "i3-session-lever" ''
      ${gui-run.locale}
      ${if-installed-code}
      lxqt-session &
      '';

  i3-session-curve-linux = writeShellScriptBin "i3-session-curve-linux" ''
      ${gui-run.locale}
      ${if-installed-code}
      lxqt-session &
      '';

  configure-input = writeShellScriptBin "configure-input" ''
      ${gui-run.locale}
      ${if-installed-code}
      TRACKBALL_DEVICE="Primax Kensington Eagle Trackball"
      TRACKBALL_ID="''$(xinput list --id-only "$TRACKBALL_DEVICE")"

      if [ -n "$TRACKBALL_ID" ] ; then
          echo "Enabling middle button emulation for trackball '$TRACKBALL_DEVICE' with id '$TRACKBALL_ID'"
          xinput set-prop $TRACKBALL_ID "libinput Middle Emulation Enabled" 1
      fi

      # Set up Synaptics touchpad palm detection
      if_installed synclient PalmDetect=1
      if_installed synclient PalmMinWidth=8
      if_installed synclient PalmMinZ=100

      # "mouse" speed and acceleration
      xset m 6 1

      # remap caps lock to ctrl
      setxkbmap -option ctrl:nocaps
      # right Win key is my Compose key
      setxkbmap -option compose:rwin
      # us & bg phonetic layout. right alt switches, caps lock lights up when bg toggled
      setxkbmap us,bg ,phonetic grp:toggle,grp_led:caps
      '';

  i3-explorer = writeShellScriptBin "i3-explorer" ''
      export XDG_DATA_DIRS=$HOME/.nix-profile/share:$HOME/.share:"''${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"
      exec pcmanfm-qt "$@"
      '';
}
