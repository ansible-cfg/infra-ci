# Create certs folder
sudo mkdir -p /volumes/gitlab/data/certs

# Copy dhparam file
sudo cp /etc/letsencrypt/dhparam.pem /volumes/gitlab/data/certs/dhparam.pem

# Copy gitlab cert
sudo cp /etc/letsencrypt/live/vm4.dev-comutitres.fr/fullchain.pem /volumes/gitlab/data/certs/gitlab.cert

# Copy gitlab key
sudo cp /etc/letsencrypt/live/vm4.dev-comutitres.fr/privkey.pem /volumes/gitlab/data/certs/gitlab.key