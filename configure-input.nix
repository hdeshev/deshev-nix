{writeShellScriptBin, glibcLocales, kbdd}:
writeShellScriptBin "configure-input" ''
if_installed() {
    which $1 > /dev/null && \
       shift && \
       $@
}

# Set up Synaptics touchpad palm detection
if_installed synclient PalmDetect=1
if_installed synclient PalmMinWidth=8
if_installed synclient PalmMinZ=100

# remap caps lock to ctrl
setxkbmap -option ctrl:nocaps
# right Win key is my Compose key
setxkbmap -option compose:rwin
# us & bg phonetic layout. right alt switches, caps lock lights up when bg toggled
setxkbmap us,bg ,phonetic grp:toggle,grp_led:caps

# per-window kbd layout selection
pkill kbdd # terminate any previous instances
${kbdd}/bin/kbdd
''
