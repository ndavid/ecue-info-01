# Le notebook du cours, ouvert de trois façons — Cours 1

Ce dossier ne contient rien de versionné : les notebooks du TD sont dérivés
des pages du cours, écrites en MyST Markdown dans
[`src/cours1/notebook/`](../../../src/cours1/notebook/), et déposés ici par

```bash
python outils/construire_notebooks.py            # convertit en .ipynb, dans produit/
python outils/construire_notebooks.py --executer # et remplit les sorties
```

Le `.ipynb` est un fichier dérivé, comme un PDF l'est d'un `.typ` : il va dans
`produit/`, et `outils/livrer_tds.py` le met à plat dans le dossier livré aux
étudiants, qui y ouvrent `04_premiers_octets.ipynb` de trois façons.

Les cellules qui lisent des fichiers cherchent le dossier de la séance, celui
qui contient `1a_formats/`, en remontant depuis le dossier courant, puis
`depart/` ou `travail/` du TD concerné : le même
notebook tourne depuis l'archive livrée, depuis le dépôt, et pendant la
construction du book.
