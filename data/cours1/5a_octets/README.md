# Les premiers octets d'un fichier — TD 5a, cours 1, facultatif

Un mini-projet Python de quarante lignes, à ouvrir dans l'éditeur de code et à
exécuter. Il lit les quatre premiers octets d'un fichier et les compare à un
catalogue de signatures, ce que fait tout logiciel qui ouvre un document.

C'est la conclusion du TD 1a, « Fichiers, formats et extensions » :
après avoir constaté que l'extension ne décrit pas le contenu, on regarde ce
qui le décrit.

Le script est versionné, comme les sources de
[`../2a_vscode_python/`](../2a_vscode_python/) et de
[`../2b_erreurs/`](../2b_erreurs/). Les fichiers qu'il lit, ceux du TD 1a, sont
produits par `make_data.py` et ne le sont pas.

## Ce que le script affiche

```
$ python octets.py
raven_une_ligne.txt          4F 6E 63 65  Once   aucune signature connue
raven_une_ligne.donnees      4F 6E 63 65  Once   aucune signature connue
raven.odt                    50 4B 03 04  PK..   archive ZIP, donc .odt, .docx, .xlsx ou .epub
raven_brut.html              3C 21 64 6F  <!do   aucune signature connue
raven.pdf                    25 50 44 46  %PDF   document PDF
```

Sortie réelle, obtenue sur les fichiers du cours.

Trois constats se lisent dans ce tableau, et ce sont les trois points de la
partie. Les deux premières lignes portent des extensions différentes et les
mêmes octets. Les trois fichiers texte n'ont aucune signature, ce qui est
justement pourquoi rien ne les distingue d'après leur début. Le `.odt` commence
par `PK`, les initiales de Phil Katz, l'auteur du format ZIP : un document
LibreOffice est une archive.

## Deux extensions échangées

Le script accepte des chemins en argument. En échangeant les extensions de deux
copies, on obtient la démonstration en deux lignes :

```bash
cp ../1a_formats/depart/raven.odt raven_odt.pdf
cp ../1a_formats/travail/raven.pdf raven_pdf.odt
python octets.py raven_odt.pdf raven_pdf.odt
```

```
raven_odt.pdf                50 4B 03 04  PK..   archive ZIP, donc .odt, .docx, .xlsx ou .epub
raven_pdf.odt                25 50 44 46  %PDF   document PDF
```

Sortie réelle. Le nom a changé, les octets non, et c'est le second que le
logiciel lit. Sous Windows, remplacer `cp` par `copy`. Les copies naissent
dans ce dossier, à côté de la commande qui les a faites ; elles ne sont pas
versionnées.

## Fichiers nécessaires

Les fichiers lus par défaut sont ceux du TD 1a, dans `../1a_formats/depart/`
— dans le dépôt, sous `1a_formats/produit/`, où `make_data.py` les fabrique :

```bash
cd data/cours1
python make_data.py fetch
python make_data.py build
```

À l'exception de `raven.pdf`, que les étudiants produisent eux-mêmes au TD 1a,
dans `../1a_formats/travail/`, par Fichier → Exporter au format PDF. S'il
manque, le script écrit `introuvable` sur cette ligne et continue.
