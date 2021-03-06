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
  stations[calmradio]="http://streams.calmradio.com:30928/stream"
  stations[yt-piano]="https://www.youtube.com/watch?v=XULUBg_ZcAU"
  stations[yt-house]="https://www.youtube.com/watch?v=KvRVky0r7YM"
  stations[solo-piano]="https://pianosolo.streamguys1.com/live"
  stations[fimbul-radio]="http://yp.shoutcast.com/sbin/tunein-station.m3u?id=99418477"

  station="$1"
  url="''${stations[$1]}"

  if [ "$url" == "" ]; then
      for station_name in "''${!stations[@]}" ; do
          printf "%20s: %s\n" $station_name ''${stations[$station_name]}
      done
  else
      exec ${mpv}/bin/mpv --no-video "$url"
  fi
'';
in
  writeShellScriptBin "radio" script
