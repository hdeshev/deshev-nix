{ writeShellScriptBin, mpv }:
let script = ''
  declare -A stations

  stations[somafm-defcon]="http://ice1.somafm.com/defcon-256-mp3"
  stations[somafm-folkforward]="http://ice1.somafm.com/folkfwd-128-mp3"
  stations[somafm-goa]="http://ice1.somafm.com/suburbsofgoa-128-aac"
  stations[somafm-groovesalad]="http://ice1.somafm.com/groovesalad-256-mp3"
  stations[somafm-lush]="http://ice1.somafm.com/lush-128-mp3"
  stations[somafm-metaldetector]="https://somafm.com/metal.pls"
  stations[somafm-thetrip]="https://somafm.com/thetrip130.pls"
  stations[somafm-thistle]="http://ice1.somafm.com/thistle-128-mp3"
  stations[zrock]="http://193.108.24.6:8000/zrock"
  stations[jega]="http://g5.turbohost.eu:8004/stream.m3u"
  stations[vipradio]="https://www.internet-radio.com/servers/tools/playlistgenerator/?u=http://149.56.175.167:5429/listen.pls?sid=1&t=.m3u"

  station="$1"
  url="''${stations[$1]}"

  if [ "$station" == "list" ]; then
      for station_name in "''${!stations[@]}" ; do
          printf "%20s: %s\n" $station_name ''${stations[$station_name]}
      done
  else
      exec ${mpv}/bin/mpv "$url"
  fi
'';
in
  writeShellScriptBin "radio" script
