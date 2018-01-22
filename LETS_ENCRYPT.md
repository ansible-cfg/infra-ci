# Lets encrypt

Nous utilisons Lets encrypt (https://letsencrypt.org/) comme autorité de certification.

Pour utiliser lets encrypt, il faut utiliser un client, nous utilisons Certbot (https://certbot.eff.org/)

tout est très bien documenté sur les différents sites.

## Installation

Suivre l'exemple de la recette [letsencrypt_VM4.yml].
 * Installation du Certbot
 * Lancement de Certbot

 Des versions/options spéciales existent pour s'integrer avec du Nginx, apache,ect.

# Fonctionnement

 certbot doit contacter letsencrypt pour demander un certificat pour un domaine donné.
 Pour vérifier le bienfondé de la requête, letsencrypt va "challenger" la requête en appellant une url précise sur le nom de domaine pour lequel on a demandé le certificat.
Une fois la requête approuvée, le certificat est reçu dans /etc/letsencrypt/live.

demander un certificat:
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
Des crons ont été ajouté dans la crontab du root sur les machines concernées.
