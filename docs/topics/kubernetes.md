# Kubernetes

![Kubernetes_Image](kube.png)

## Qu'est que Kubernetes ?

Kubernetes est un système open source qui vise à fournir une « plate-forme permettant d'automatiser le déploiement, la montée en charge et la mise en œuvre de conteneurs d'application sur des grappes de serveurs ».

## Comment lancer un déploiement sur kubernetes ?

Il vous faut uniquement un fichier whanos.yml a la racine du repositorie
Formatter dans ce style:
```Ini
ports: EXPECTED_PORT
replicas: EXPECTED_REPLICAS
```
Les deux variables ne sont pas nécéssaire au bon fonctionnement du déploiement

## Ou trouver les urls ?

Regarder dans la console de jenkins un log vous dis exactement l'url pour trouver votre projet !