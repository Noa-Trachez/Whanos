# Jenkins

![Jenkins_Image](jenkins.png)

## Qu'est que Jenkins ?

Jenkins est un outil open-source populaire utilisé dans le domaine du DevOps pour automatiser le processus de développement logiciel. Il offre une plateforme d'intégration continue (CI) qui permet aux développeurs de fusionner leur code plus fréquemment et de manière plus fiable.

## Utilisation de Jenkins dans notre projet

Dans le cadre de ce projet jenkins vas nous servir à:

- Généré et stocké toutes nos images de bases Docker
- Lier un projet Git avec notre architecture<br />(Ces actions sont effectuées à chaque changement sur le repos (checker toutes les minutes)):
  - Générée, l'image Docker du projet Git l'a stocké sur notre Docker Registry.
  - Si applicable, déployer cette image sur un cluster Kubernetes

## Les plugins utilisé ?

### Casc

Pour automatisé la configuration de notre Jenkins, quoi de mieux que le plugin Configuration As Code de Jenkins.

### Job Dsl

Pour simplifier tout le déploiement des Jobs, nous avons utilisé le plugin Job dsl de Jenkins

Vous pouvez d'ailleurs voir la configuration de ces Jobs a ce path:
```Bash
roles/jenkins/files/jobs
```

### Docker
Notre Jenkins doit conteneuriser nos applications, c'est pour cela que nous l'installons nativement sur le VPS et non grâce à Docker

Car je cite:<br />
"Using Docker in Jenkins is a good idea.<br />
Using Docker in Jenkins in Docker is a very bad idea"

### Git

Le but du projet étant de permettre un déploiement continu grâce à une liaison avec un Git, c'était compliqué de ne pas utiliser ce plugin.