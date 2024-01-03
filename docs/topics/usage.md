# Comment utilisé notre projet

## Avant de commencer !

Soyer sur d'avoir:
- Ansible d'installer sur votre machine
- Un Ubuntu server accessible via internet (nous l'avons testé sur un VPS hostinger)
- Toutes les librairies ssh (tels que sshpass) pour vous connecter à des machines distantes depuis votre ordinateur

## Clone le repos
```bash
git clone https://github.com/EpitechPromo2026/B-DOP-500-LIL-5-1-whanos-benjamin.goussard.git Whanos
cd Whanos
```

## Modifier les fichiers de configuration

### 1. vars/default.yml
```yaml
jenkins_admin_password: "VOTRE MOT DE PASSE"
jenkins_home: "/var/lib/jenkins"
jenkins_host: "localhost"
jenkins_port: "8084"

docker_registry_port: "8081"

jenkins_domain: "VOTRE NOM DE DOMAIN POUR JENKINS (subdomain.domain.com)"
registry_domain: "VOTRE NOM DE DOMAIN POUR DOCKER REGISTRY (subdomain.domain.com)"
```

### 2. inventory/hosts.ini
```Ini
[vps_servers]
vps1 ansible_host=YOUR_HOST_IP ansible_user=YOUR_VPS_USER_NAME ansible_password=YOUR_VPS_USER_PASSWORD
```
> **Pour plus de sécurité**
>
> Si vous pouvez vous connecter avec votre clé ssh sur votre VPS ne rentrez pas de ansible_password
>
{style="tip"}

### 3. roles/kubernetes/files/terraform/service_account.json
- Placez votre clé de service en .json a l'emplacement du titre
> **Récuperer ce fichier**
>
> Si vous ne savez pas creer un compte de service GCP regarder [ici](find-gcp-files.md)
>
{style="note"}



## Lancer l'intallation de l'infrastructure Whanos

```bash
./run.sh
```

## Configuration de Jenkins

![jenkins_1.png](jenkins_1.png)

Rendez vous dans la configuration de Jenkins

![Screenshot 2023-12-16 at 17.06.39.png](jenkins_2.png)

Dans la partie sécurité, rendez vous dans la configuration des informations d'identification

![Screenshot 2023-12-16 at 17.10.26.png](jenkins_4.png)

Une fois sur cette page, vous pouvez ajouter des informations d'identification

![Screenshot 2023-12-16 at 17.17.39.png](jenkins_5.png)

Il vous suffit de remplir les informations afin d'ajouter une clé SSH à Jenkins

## Configuration de la sécurité

Rendez vous dans la configuration de Jenkins, puis dans Sécurité afin de changer ce paramètre.

![jenkins_6.png](jenkins_6.png)

## Créer les images docker de base

Rendez-vous sur le dashboard, puis dans le dossier 'Whanos base images' afin de lancer la création des images de bases nécessaires avant toute création de lien avec un projet.

## Lier un projet

Sur le dashboard, lancez la tâche 'Link Project' afin de lier votre projet à l'infrastructure Whanos