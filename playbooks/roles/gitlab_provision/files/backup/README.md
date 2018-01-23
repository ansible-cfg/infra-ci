Les données sauvegardés du serveur Gitlab-CI incluent les données de la base PostgreSQL, les données du serveur Gitlab-CI et les repositories des projets. La sauvegarde et la restauration des données peut se faire à chaud ou à froid suivant le besoin. Pourtant, il est recommandé d'utiliser la méthode de sauvegarde et de restauration à froid.

# Sauvegarde et restauration à chaud
L'infrastructure d'intégration continue doit être disponible pour exécuter correctement la sauvegarde et la restauration des données à chaud.

## Sauvegarde des données
La sauvegarde des données peut se faire sans interruption de service. Pour faire une sauvegarde, il suffit d'exécuter le script shell *gitlab-hot-backup.sh* sur la machine qui héberge le conteneur du serveur gitlab-ci. Les données de la base Postgresql et les données du serveur gitlab-ci seront sauvegardés dans un fichier compressé dans le dossier */Volumes/srv/gitlab/ci/data/backups*. Le fichier sauvegardé doit être transféré sur un serveur de sauvegarde ou d'archivage des données.

### Exemple :
*Lancer la sauvegarde :*
```
./gitlab-hot-backup.sh
```

*Transférer le fichier dans le bastion :*
```
scp -p /volumes/gitlab/data/backups/1516628251_2018_01_22_10.3.3_gitlab_backup.tar amin@vm2.dev-comutitres.fr:/backups
```

## Restauration des données
La restauration des données peut se faire sans interruption de service. Pour cela, il suffit d'exécuter le script shell *gitlab-hot-restore.sh* en passant en paramètre l'identifiant de la copie de sauvegarde à restaurer. Avant d'exécuter la restauration, le fichier à restaurer doit exister dans le dossier */volumes/gitlab/data/backups* de la machine qui héberge le serveur Gitlab-CI.

### Exemple :
*Transférer un fichier depuis le bastion :*
```
scp -p /backups/1516628251_2018_01_22_10.3.3_gitlab_backup.tar amin@vm4.dev-comutitres.fr:/volumes/gitlab/data/backups
```

*Lancer une restauration :*
```
./gitlab-hot-restore.sh 1516628251_2018_01_22_10.3.3
```

# Sauvegarde et restauration à froid
