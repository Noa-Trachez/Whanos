# Docker Registry

![Docker_Image](docker-registry.png)

Le Docker Registry nous permet de stocker toutes nos images compilées par notre projet et de les rendre disponibles a tout le monde !
## Qu'est qu'un docker registry ?

Un Docker registry est un service qui stock et gère des images Docker.

Le Docker Hub est l'un des registres Docker publics les plus connus.

Il est également possible de créer et de gérer des registres privés pour un contrôle accru sur la distribution et la sécurité des images.


## Fonctionnement de notre Docker Registry

> **Docker Registry**
>
> Si votre VPS n'est pas sécurisé avec le protocol https vous pouvez voir cette erreur survernir:<br />
> "Server gave http response to https client"<br />
> Voici la marche a suivre: [Link](fix-http-error.md)<br />
>
{style="warning"}

### La sécurité

Pour l'instant, n'importe qui possédant l'ip et le port de votre registry pourra envoyer et recevoir des images

### L'envoie d'image

```Bash
docker build . -t MON_REGISTRY/MON_NAMESPACE/MON_PROJET:latest
docker tag MON_REGISTRY/MON_NAMESPACE/MON_PROJET:latest 
docker push MON_REGISTRY/MON_NAMESPACE/MON_PROJET:latest
```

Par exemple:

```Bash
docker build -t alpinemysql .
docker tag alpinemysql localhost:5000/alpinemysql
docker push localhost:5000/alpinemysql
```

### La reception d'image

```Bash
docker pull MON_REGISTRY/MON_NAMESPACE/MON_PROJET
```

Par exemple:

```Bash
docker pull localhost:5000/alpinegit
```


### Lister les images

```Bash
curl -X GET http://MON_REGISTRY/v2/_catalog
```

Par exemple:

```Bash
curl -X GET http://localhost:5000/v2/_catalog
```
