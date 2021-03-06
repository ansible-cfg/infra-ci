# Delete the expired backup files older than 7 days
find /volumes/gitlab/data/backups -mtime +7 -exec sudo rm {} \;

# Run hot backup on gitlab-ci container
sudo docker exec -i gitlab-ci bundle exec rake gitlab:backup:create

# Get the last backup file
LAST_BACKUP_FILE=$(sudo ls -1t /volumes/gitlab/data/backups/* | head -1)

# Add write permission to the last modified backup file
sudo chmod 755 $LAST_BACKUP_FILE

# Transfer backup file to the archive machines
/bin/sh /backup/scripts/transfer-backups.sh $LAST_BACKUP_FILE
