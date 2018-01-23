# Sommaire

# Etape 0 : On reçoit une nouvelle machine

## Clé SSH

Supprimer le host des `known_hosts`; cela arrive lorsque l'on réinitialise un vps sur OVH.

```
ssh-keygen -R vps502106.ovh.net
```

Copie sa clé publique ssh pour l'utilisateur `root` pour faciliter l'utilisation de ansible:

```
cat ~/.ssh/id_rsa.pub | ssh root@vps502106.ovh.net 'cat >> ~/.ssh/authorized_keys'
```

## Verouillage de `root`

*Objectifs:*

* Modifie le mot de passe `root`
* Déclare l'utilisateur (`arnauld`) qui nous servira à configurer la machine (sudoer avec sa clé publique)
* empêche l'accès SSH au user `root`

### Sur une machine

```
ansible-playbook -i "vps502106.ovh.net," playbooks/invalidate_root.yml
```

### Sur toutes les machines de l'inventaire

Ce playbook peut échouer sur certains host si le `root` a déjà été désactivé

```
ansible-playbook -i inventory/ovh-alo.yml playbooks/invalidate_root.yml
```

### Si un sudoer existe déjà et root n'est plus autorisé

Une fois qu'un sudoer est créé il est possible de l'utiliser (d'autant plus que root n'est plus autorisé en ssh):

*Attention* remplacer `arnauld` par votre propre login sudoer
`-u arnauld` pour indiquer à ansible d'utiliser le user 'arnauld'

```
ansible-playbook -i inventory/ovh-vec-ci.yml playbooks/invalidate_root.yml -u arnauld
```

Inspiration:
> Note the comma (,) at the end; this signals that it's a list, not a file.
> [stackoverflow](https://stackoverflow.com/a/18199029)

# Etape 2 : Déclarer les utilisateurs

*Attention* remplacer `arnauld` par votre propre login sudoer.
`-u arnauld` pour indiquer à ansible d'utiliser le user 'arnauld'

```
ansible-playbook -i inventory/ovh-vec-ci.yml playbooks/declare_users.yml -u arnauld
```

# Etape 3 : Protéger la machine :warning:

*Attention* remplacer `arnauld` par votre propre login sudoer.
`-u arnauld` pour indiquer à ansible d'utiliser le user 'arnauld'

:warning: cette étape modifie les IPtables des machines et empêchera les connexions directes par ssh.

```
ansible-playbook -i inventory/ovh-vec-ci.yml playbooks/protect_server.yml -u arnauld
```

puis

```
ansible-playbook -i inventory/ovh-vec-ci.yml playbooks/generate_iptables.yml -u arnauld
```

Pour limiter à un groupe de machine (e.g. `bastion`) uniquement:

```
ansible-playbook -i inventory/ovh-vec-ci -l bastion playbooks/generate_iptables.yml -u arnauld
```

# Etape 4 : Installer la machine Nginx

Une des machines (actuellement VM2) servira de "breaking glass" HTTP. C'est elle qui sera ouverte en public et redirigera les flux HTTP/HTTPS vers les bonnes machines.
C'est elle qui fera par exemple qu'en appellant gitlab.dev-comutitres.fr nous arrivions sur la machine gitlab en HTTPS.

Pour cela nous allons utiliser Nginx.

## Mise en place HTTPS

Pour les certificats, nous utiliserons [Let's Ecnrypt](LETS_ENCYPT.md).

## Deployer Nginx

```
ansible-playbook -i inventory/ovh-vec-ci.yml playbooks/install_nginx.yml -u arnauld
```

TODO firewald pour ouvrir les ports

# Etape 5 : Installer la base des données PostgreSQL pour le Gitlab-CI

*Attention* remplacer `arnauld` par votre propre login sudoer.
`-u arnauld` pour indiquer à ansible d'utiliser le user 'arnauld'

-TODO firewald pour ouvrir les ports
```
ansible-playbook -i inventory/ovh-vec-ci.yml playbooks/install_postgres.yml -u arnauld
```

# Etape 6 : Installer le Redis pour le Gitlab-CI

*Attention* remplacer `arnauld` par votre propre login sudoer.
`-u arnauld` pour indiquer à ansible d'utiliser le user 'arnauld'

```
ansible-playbook -i inventory/ovh-vec-ci.yml playbooks/install_redis.yml -u arnauld
```

# Etape 7 : Installer la machine Gitlab-CI

## Initialiser les serveurs de sauvegarde

*Attention* remplacer `arnauld` par votre propre login sudoer.
`-u arnauld` pour indiquer à ansible d'utiliser le user 'arnauld'

```
ansible-playbook -i inventory/ovh-vec-ci.yml playbooks/init_backup.yml -u arnauld
```

## Installer Gitlab-CI

*Attention* remplacer `arnauld` par votre propre login sudoer.
`-u arnauld` pour indiquer à ansible d'utiliser le user 'arnauld'

```
ansible-playbook -i inventory/ovh-vec-ci.yml playbooks/install_gitlab.yml -u arnauld
```

## Activer la sauvegarde des données Gitlab-CI

La sauvegarde des données Gitlab se fait à chaud et à froid.
La sauvegarde à chaud se fait tout les soirs à deux heures matin.
La sauvegarde à froid se fait tout les samedis à 10h du matin.
Deux crons sont installés sur la machine qui héberge le serveur `Gitlab-CI`.
Nous gardons un historique de 7 jours des sauvegardes.
Les fichiers sauvegardés sont transférés dans le dossiers `/backups` sur les serveurs de sauvegarde vm1 et vm2.

[Manuel d'utilisation des scripts de sauvegarde et de restauration des données.](playbooks/roles/gitlab_provision/files/backup/README.md)