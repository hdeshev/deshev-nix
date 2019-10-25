{ gui-run, writeText, writeShellScriptBin, bash }:
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

      xscreensaver -no-splash &

      if [ "$(pidof redshift)" ] ; then
          echo "redshift already running"
      else
          if_installed redshift-gtk -l 42.75:23.20&
      fi

      ${bash}/bin/bash "$HOME/.fehbg"

      #clipboard history
      if [ "$(pidof parcellite)" ]
      then
        echo "parcellite already running"
      else
        parcellite &
      fi

      #per-window kbd layout selection
      if [ "$(pidof kbdd)" ]
      then
        echo "kbdd already running"
      else
        kbdd
      fi

      # Start the XFCE settings daemon to make GUI programs look good
      xfsettingsd --replace

      # Network Manager applet - connect to various networks (eth, wlan)
      if [ "$(pidof nm-applet)" ]
      then
        echo "nm-applet already running"
      else
        nm-applet &
      fi

      xfce4-power-manager
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
}
