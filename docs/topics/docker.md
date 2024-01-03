# Docker Image

![Docker_Image](docker.png)

Si vous voulez voir le code des différentes images, celles-ci sont situées dans le dossier image/`{langage}`

## Qu'est que image Whanos ?

### image Whanos:
- Elle doit être basée sur une image officielle de docker
- Elle doit utiliser bash
- Si applicable, Elle doit copier et installer les dépendances
- Elle doit Copier les ressources.
- Si applicable, Elle doit compiler l'application et retirer tous les fichiers inutiles

## Fonctionnement de nos images pour le projet

### Image standalone:
- Elle est destinée au application qui n'ont pas besoin de plus de configuration que ce que nous avons prévue
- Elle doit pouvoir compiler et lancer l'application sans aucune modification exterieur
- Est utilisée quand aucun Dockerfile n'est fournis
- Les notres sont basé sur nos image de base (ce qui signifie que les images de bases doivent être "compilé" avant de pouvoir les construires)

### Image de base:
- Elle est destinée au application qui ont besoin de plus de configuration que ce que nous avons prévue
- Elle sont destiné a être utilisé depuis un FROM
- Est utilisée quand un Dockerfile est fournis
- Elle doit pouvoir être compilée sous cette forme:
```
docker build -t whanos-something - < Dockerfile.base
```
