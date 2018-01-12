# Etape 0 : On reçoit une nouvelle machine

## Clé SSH

Supprimer le host des `known_hosts`; cela arrive lorsque l'on réinitialise un vps sur OVH.

```
ssh-keygen -R vps502106.ovh.net
```

Copie sa clé publique ssh pour l'utilisateur root pour faciliter l'utilisation de ansible:

```
cat ~/.ssh/id_rsa.pub | ssh root@vps502106.ovh.net 'cat >> ~/.ssh/authorized_keys'
```

## Verouillage de `root`

*Objectifs:*

* Modifie le mot de passe `root`
* Déclare l'utilisateur (`arnauld`) qui nous servira à configurer la machine (sudoer avec sa clé publique)
* empêche l'accès SSH au user `root`


```
ansible-playbook -i "vps502106.ovh.net," playbooks/invalidate_root.yml
```

Une fois qu'un sudoer est créé il est possible de l'utiliser:

```
ansible-playbook -i inventory/ovh-vec-ci playbooks/invalidate_root.yml -u arnauld
```


Inspiration:
> Note the comma (,) at the end; this signals that it's a list, not a file.
> [stackoverflow](https://stackoverflow.com/a/18199029)

# Etape 1: Protéger la machine


```
ansible-playbook -i inventory/ovh-alo playbooks/protect_server.yml -u arnauld
```

Note: `-u arnauld` pour utiliser que ansible utilise le user 'arnauld' sur le remote.

Pour limiter à un groupe de machine (e.g. `bastion`) uniquement:

```
ansible-playbook -i inventory/ovh-alo -l bastion playbooks/protect_server.yml -u arnauld
```


