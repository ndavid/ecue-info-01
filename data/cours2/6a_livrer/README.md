# Publier une version — TD 6a, cours 2

Questions 26 et 27 du TP. Le projet est dans un état satisfaisant : on le
ramène dans `master` et on nomme la version obtenue.

Ce TD n'a pas de fichier de départ : on travaille dans le projet créé au
TD 3a, `../3a_premier_depot/travail/projet_2`.

## Déroulé

```bash
git checkout master
git merge develop
git tag -a v1.0 -m "première version de la calculatrice"
```

## Vérifier

```bash
git llog     # master et develop sur le même commit, avec l'étiquette à côté
git tag      # v1.0
python src/main.py
```

C'est le schéma des bonnes pratiques joué en vrai : `master` ne reçoit que des
versions complètes, et le tag leur donne un nom lisible, là où le commit ne
porte qu'une empreinte. Ce dépôt-ci procède de la même façon pour livrer
chaque séance.
