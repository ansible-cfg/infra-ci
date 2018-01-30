# Docker registry

L'image du bouchon est présente sur notre registry: vm4.dev-comutitres.fr:5000/bouchon-ctu-pour-vec:3.12.3
Pour l'instant poussée à la main:

```
docker tag bouchon-ctu-pour-vec:3.12.3 vm4.dev-comutitres.fr:5000/bouchon-ctu-pour-vec:3.12.3
docker push
```


# Demo

Lancer le consumer en local: 

```
 sudo docker run -e CTU_RABBIT_HOST=dev5.dev-comutitres.fr -e CTU_CONF_FILE=application-journey-consumer.yml vm4.dev-comutitres.fr:5000/bouchon-ctu-pour-vec:3.12.3
```

Lancer le producer sur dev6:  

```
sudo docker run -v /tmp/csv:/tmp/csv -e CTU_RABBIT_HOST=dev5.dev-comutitres.fr -e CTU_CONF_FILE=application-journey-producer.yml vm4.dev-comutitres.fr:5000/bouchon-ctu-pour-vec:3.12.3
```

Voir les messages s'empiler dans RabbitMQ: 
http://dev5.dev-comutitres.fr:15672


Lancer le consumer en local:

```
 sudo docker run -e CTU_RABBIT_HOST=dev5.dev-comutitres.fr -e CTU_CONF_FILE=application-journey-consumer.yml vm4.dev-comutitres.fr:5000/bouchon-ctu-pour-vec:3.12.3
```

Voir la file RabitMQ se vider.
Voir passer les messages sur la console du consumer.








