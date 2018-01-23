# Sauvegarde et restauration des données
Les données sauvegardés du serveur Gitlab-CI incluent les données de la base PostgreSQL, les données du serveur Gitlab-CI et les repositories des projets. La sauvegarde et la restauration des données peut se faire à chaud ou à froid suivant le besoin. Pourtant, il est recommandé d'utiliser la méthode de sauvegarde et de restauration à froid.

## Sauvegarde et restauration des données à chaud
L'infrastructure d'intégration continue doit être disponible pour exécuter correctement la sauvegarde et la restauration des données à chaud.

### Sauvegarde des données
La sauvegarde des données peut se faire sans interruption de service. Pour faire une sauvegarde, il suffit d'exécuter le script shell *hot-backup.sh* sur la machine qui héberge le conteneur du serveur gitlab-ci. Les données de la base Postgresql et les données du serveur gitlab-ci seront sauvegardés dans un fichier compressé dans le dossier */Volumes/srv/gitlab/ci/data/backups*. 

Le fichier sauvegardé est ensuite transféré sur un serveur de sauvegarde ou d'archivage des données.

#### Exemple :
*Lancer la sauvegarde :*
```
./hot-backup.sh
```

### Restauration des données
La restauration des données peut se faire sans interruption de service. Pour cela, il suffit d'exécuter le script shell *hot-restore.sh* en passant en paramètre l'identifiant de la copie de sauvegarde à restaurer. Avant d'exécuter la restauration, la sauvegarde doit être déposée le dossier */volumes/gitlab/data/backups* de la machine qui héberge le serveur Gitlab-CI.

#### Exemple :
*Lancer une restauration :*
```
./hot-restore.sh 1516628251_2018_01_22_10.3.3
```

## Sauvegarde et restauration des données à froid
Le serveur Gitlab-CI doit être arrêté pour exécuter correctement la sauvegarde et la restauration des données à froid.

### Sauvegarde des données
Pour faire une sauvegarde à froid, il suffit d'exécuter le script shell *cold-backup.sh* sur la machine qui héberge le conteneur du serveur gitlab-ci. Les données de la base Postgresql et les données du serveur gitlab-ci seront sauvegardés dans un fichier compressé dans le dossier */Volumes/srv/gitlab/ci/data/backups*. 

Le fichier sauvegardé est ensuite transféré sur un serveur de sauvegarde ou d'archivage des données.

#### Exemple :
*Lancer la sauvegarde :*
```
./cold-backup.sh
```

### Restauration des données
La restauration des données à froid se fait en exécutant le script shell *cold-restore.sh* et en passant l'identifiant de la copie de sauvegarde à restaurer en paramètre du script. Avant d'exécuter la restauration, la sauvegarde doit être déposée dans le dossier */volumes/gitlab/data/backups* de la machine qui héberge le serveur Gitlab-CI.

#### Exemple :
*Lancer une restauration :*
```
./hot-restore.sh 1516628251_2018_01_22_10.3.3
```