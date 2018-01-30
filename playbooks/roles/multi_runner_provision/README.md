# Installer Gitlab Runner

*Attention* remplacer `arnauld` par votre propre login sudoer.
`-u arnauld` pour indiquer à ansible d'utiliser le user 'arnauld'

```
ansible-playbook -i inventory/ovh-vec-ci.yml playbooks/install_multi_runner.yml -u arnauld
```

# Ajouter le Certificat d'autorité Let’s Encrypt

Il est nécessaire d'adapter la configuration généré par Gitlab Runner pour que Git puisse cloner les projets avant d'exécuter la pipeline.

Pour cela, il faut éditer le fichier de configuration `/etc/gitlab-runner/config.toml` qui contient l'ensemble des runners crées avec le rôle `multi_runner_provision`.

Dans la section `runners`, ajouter la ligne suivante :

`pre_clone_script = "update-ca-certificates;git config --global http.https://gitlab.dev-comutitres.fr.sslcainfo /etc/ssl/certs/ca-certificates.crt`

Dans la section `runners.docker`, ajouter ou modifier les lignes suivantes :

`tls_verify = true`
`disable_cache = true`
`volumes = ["/etc/gitlab-runner/certs/ca.crt:/usr/local/share/ca-certificates/ca.crt"]`

Un exemple de fichier `config.toml` :

```
concurrent = 1
check_interval = 0

[[runners]]
  name = "ci-multi-runner"
  url = "https://gitlab.dev-comutitres.fr"
  token = "69d4d506e680dfcd59d3376394ceb5"
  tls-ca-file = "/usr/local/share/ca-certificates/ca.crt"
  executor = "docker"
  pre_clone_script = "update-ca-certificates;git config --global http.https://gitlab.dev-comutitres.fr.sslcainfo /etc/ssl/certs/ca-certificates.crt"
  [runners.docker]
    tls_verify = false
    image = "docker"
    privileged = false
    disable_cache = true
    volumes = ["/etc/gitlab-runner/certs/ca.crt:/usr/local/share/ca-certificates/ca.crt"]
    shm_size = 0
```