# Let's encrypt
Nous utilisons [Let's encrypt](https://letsencrypt.org/) comme autorité de certification.
Pour utiliser lets encrypt, il faut utiliser un client, nous utilisons [Certbot](https://certbot.eff.org/)

Tout est très bien documenté sur les différents sites.

## Installation
Suivre l'exemple de la recette [letsencrypt_VM4.yml].
 * Installation du Certbot
 * Lancement de Certbot

 Des versions/options spéciales existent pour s'integrer avec du Nginx, apache,ect.

# Fonctionnement

Certbot doit contacter letsencrypt pour demander un certificat pour un domaine donné.

Pour vérifier le bienfondé de la requête, letsencrypt va "challenger" la requête en appellant une url précise sur le nom de domaine pour lequel on a demandé le certificat.

Une fois la requête approuvée, le certificat est reçu dans /etc/letsencrypt/live.

Demander un certificat:
```
certbot certonly
```
Les options suivantes peuvent être utiles:
--standalone : permet à certbot de monter temporairement un server pour exposer l'url de challenge (sinon il faut l'exposer sur son apache/nginx/etc)
--dry-run pour simplement simuler les actions

Renouveller un certificat:
```
certbot renew
```
--cert-path,--fullchain-path,--key-path,ect possibilité de donner le path des certificats (pratique pour les renouveller dans un container docker directement)

# Renouvellement
Des crons ont été ajoutés dans la crontab du root des machines concernées.

Check certificate:

```
sudo openssl x509 -in cert.pem -text -noout
```

## VM2

```
$ ssh vm2.dev-comutitres.fr
$ sudo systemctl stop nginx
$ sudo certbot renew
$ sudo systemctl start nginx
```

## VM4
