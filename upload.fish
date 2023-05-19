while true
    if not test -e /home/dorebell/.cronlock
        touch /home/dorebell/.cronlock
	echo "cronjob started at" (date +%H:%M) >> /opt/rclone/cron.log
            /usr/bin/rclone move /mnt/secrets-local chunker: \
              --config /home/dorebell/.config/rclone/rclone.conf \
              --log-file /opt/rclone/logs/upload.log --log-level INFO \
              --delete-empty-src-dirs --fast-list --min-age 1h \
              --transfers 1 --buffer-size 2G --max-duration 2h30m \
              --cutoff-mode cautious --drive-chunk-size 512M --progress
        echo "cronjob finished at" (date +%H:%M) >> /opt/rclone/cron.log
        rm -f /home/dorebell/.cronlock
        break
    else 
        echo "rclone locked at" (date) ", sleeping for 10m" >> /opt/rclone/cron.log
        sleep 10m
    end
end


