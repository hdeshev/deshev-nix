{ gui-wrapper, shutter, xclip, s3cmd, libnotify }:
gui-wrapper "shoot" ''
  BUCKET=s3://sh.deshev.com
  URL_ROOT=http://sh.deshev.com
  LOCAL_BUCKET_ROOT=/data/deshev/sh.deshev.com
  SCREENSHOT_ROOT=s

  MONTH_DIR=$(date +%Y-%m)
  FILENAME=$(date +%Y%m%d%H%M%S.png)
  RELATIVE_PATH="$SCREENSHOT_ROOT/$MONTH_DIR/$FILENAME"
  LOCAL_PATH="$LOCAL_BUCKET_ROOT/$RELATIVE_PATH"
  REMOTE_PATH="$BUCKET/$RELATIVE_PATH"
  URL="$URL_ROOT/$RELATIVE_PATH"

  upload_image() {
      ${s3cmd}/bin/s3cmd put -P $LOCAL_PATH $REMOTE_PATH
  }

  # Wait for the shortcut keyboard event to go to heaven and not break our scrot invocation
  sleep 0.5s

  mkdir -p "$(dirname $LOCAL_PATH)"
  gui-run ${shutter}/bin/shutter -e -s -o "$LOCAL_PATH"

  if [ -f $LOCAL_PATH ] ; then
      if upload_image ; then
          echo "$URL" | ${xclip}/bin/xclip -selection c
          ${libnotify}/bin/notify-send "Screenshot uploaded: $URL"
      else
          ${libnotify}/bin/notify-send "Upload failed!"
      fi
  else
      ${libnotify}/bin/notify-send "Screenshot cancelled."
  fi
''
