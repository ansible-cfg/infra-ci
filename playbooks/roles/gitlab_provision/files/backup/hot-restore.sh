# Download the backup file to restore
scp -p robocop@vm1.dev-comutitres.fr:/backups/$1_gitlab_backup.tar /home/robocop

# Copy the downloaded file in backups directory
sudo cp /home/robocop/$1_gitlab_backup.tar /volumes/gitlab/data/backups

# Run hot restore on gitlab-ci container within backup identifier
sudo docker exec -it gitlab-ci bundle exec rake gitlab:backup:restore BACKUP=$1

# Copy certs
/bin/sh /backup/scripts/copy-certs.sh

# Clear gitlab cache
sudo docker exec -it gitlab-ci chown -R git:git /home/git/
sudo docker exec -it gitlab-ci bundle exec rake cache:clear RAILS_ENV=production

# /!\ Sometimes, repositories are empty after data restore. 
# You have to clean cache on Redis container using redis-cli.