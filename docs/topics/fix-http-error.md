# Fix Docker Registry Error Http Response to HTTPS

> **IP**
>
> N'oubliez pas de remplacer l'ip que nous vous mettons en exemple par celle de votre VPS
>
{style="note"}

## Avec l'interface Graphique
![First_Step](first_step.png)

![Other_Step](all_steps.png)

## Sans interface Graphique

Selon votre système d'exploitation, choisissez l'étape à suivre.
Une fois, cette étape réalisée, redémarrez votre Docker.
(PS: Vous pouvez aussi redemarrer votre machine pour être sûr !)

### Windows:
Ajouter cette ligne:
```JSON
"insecure-registries": ["62.72.19.90:80"]
```
Dans votre fichier daemon.json avec ce path
```Bash
C:\ProgramData\Docker\config\daemon.json
```

### Linux:
Ajouter cette ligne:
```JSON
"insecure-registries": ["62.72.19.90:80"]
```
Dans votre fichier daemon.json avec ce path
```Bash
/etc/docker/daemon.json.j2
```

