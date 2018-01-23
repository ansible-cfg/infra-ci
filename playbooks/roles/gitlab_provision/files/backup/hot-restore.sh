# Download the backup file to restore
scp -p robocop@vm1.dev-comutitres.fr:/backups/$1_gitlab_backup.tar robocop@vm4.dev-comutitres.fr:/volumes/gitlab/data/backups

# Run hot restore on gitlab-ci container within backup identifier
sudo docker exec -it gitlab-ci bundle exec rake gitlab:backup:restore BACKUP=$1