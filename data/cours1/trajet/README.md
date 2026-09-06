# Données — Manipulation « trajet » du cours 1

Le même livrable, une vidéo montrant le chemin de la gare à l'école, produit
deux fois : en assemblant des applications graphiques, puis en une commande.
La comparaison est le propos ; la vidéo n'est qu'un prétexte.

Comme pour le reste de `data/`, ce dossier versionne la recette et non le
produit : `carte.png`, les images d'étape et `trajet.mp4` sont générés, donc
ignorés par git.

## Ce que contient le dossier

| Fichier | Rôle |
|---------|------|
| `carte.py` | assemble le fond de carte à partir de tuiles OpenStreetMap, et convertit longitude/latitude en pixels |
| `etapes.csv` | les cinq étapes : durée, point d'arrivée en pixels, texte affiché |
| `anime.sh` | dessine une image par étape (ImageMagick), écrit les sous-titres, monte la vidéo (ffmpeg) |

## Utilisation

```bash
conda activate info01          # ffmpeg et imagemagick y sont déjà installés

python carte.py                # fabrique carte.png (une fois, avec le réseau)
./anime.sh                     # fabrique trajet.mp4
```

`carte.py` accepte aussi un tracé exporté depuis uMap, ce qui permet de partir
du trajet dessiné à la souris :

```bash
python carte.py trajet.geojson # écrit etapes.csv, dont les textes restent à saisir
```

## Ce que l'enseignant prépare avant la séance

1. Lancer `python carte.py` une fois et **distribuer `carte.png`** avec les
   supports. Le serveur de tuiles d'OpenStreetMap est un service bénévole dont
   les conditions d'usage interdisent le téléchargement en masse : trente
   étudiants ne doivent pas le solliciter en même temps.
2. Vérifier les coordonnées en pixels d'`etapes.csv` sur la carte produite ;
   elles dépendent de la zone choisie (`BBOX` dans `carte.py`).
3. Rédiger les cinq textes d'étape, ou les laisser à écrire aux étudiants.

## Zone couverte

`BBOX` vaut par défaut la Cité Descartes, de la gare de Noisy-Champs à
l'avenue Blaise Pascal. Changer cette constante suffit à déplacer la
manipulation ailleurs ; les coordonnées d'`etapes.csv` sont alors à refaire.

## Licence des données cartographiques

Le fond de carte provient d'OpenStreetMap, sous licence ODbL. La mention
« © les contributeurs d'OpenStreetMap » est incrustée par `carte.py` en bas de
l'image et doit y rester.
