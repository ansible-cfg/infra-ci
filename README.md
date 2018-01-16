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
ansible-playbook -i inventory/ovh-alo playbooks/invalidate_root.yml
```

### Si un sudoer existe déjà et root n'est plus autorisé

Une fois qu'un sudoer est créé il est possible de l'utiliser (d'autant plus que root n'est plus autorisé en ssh):

*Attention* remplacer `arnauld` par votre propre login sudoer
`-u arnauld` pour indiquer à ansible d'utiliser le user 'arnauld'

```
ansible-playbook -i inventory/ovh-vec-ci playbooks/invalidate_root.yml -u arnauld
```


Inspiration:
> Note the comma (,) at the end; this signals that it's a list, not a file.
> [stackoverflow](https://stackoverflow.com/a/18199029)

# Etape 2: Déclarer les utilisateurs

*Attention* remplacer `arnauld` par votre propre login sudoer.
`-u arnauld` pour indiquer à ansible d'utiliser le user 'arnauld'


```
ansible-playbook -i inventory/ovh-vec-ci playbooks/declare_users.yml -u arnauld
```

# Etape 3: Protéger la machine :warning: 

*Attention* remplacer `arnauld` par votre propre login sudoer.
`-u arnauld` pour indiquer à ansible d'utiliser le user 'arnauld'

:warning: cette étape modifie les IPtables des machines et empêchera les connexions directes par ssh.

```
ansible-playbook -i inventory/ovh-vec-ci playbooks/protect_server.yml -u arnauld
```

puis

```
ansible-playbook -i inventory/ovh-vec-ci playbooks/generate_iptables.yml -u arnauld
```

Pour limiter à un groupe de machine (e.g. `bastion`) uniquement:

```
ansible-playbook -i inventory/ovh-vec-ci -l bastion playbooks/generate_iptables.yml -u arnauld
```


