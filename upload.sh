#!/usr/bin/fish
if test -e /home/dorebell/.cronlock
    touch /home/dorebell/.cronlock
  /usr/bin/rclone move /mnt/secrets-local secrets: \
      --config /home/dorebell/.config/rclone/rclone.conf \
      --log-file /opt/rclone/logs/upload.log --log-level INFO \
      --delete-empty-src-dirs --fast-list --min-age 1h \
      --progress --transfers 2 --buffer-size 2G \
      --drive-chunk-size 512M
rm ~/.cronlock


