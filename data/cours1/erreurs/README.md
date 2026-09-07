# Trois programmes fautifs — Cours 1

Trois fichiers courts qui ne s'exécutent pas. Chacun porte une faute d'écriture
d'un genre différent, et chacune se voit dans l'éditeur avant d'être lancée : le
soulignement de l'extension du langage désigne la ligne, comme un correcteur
orthographique désigne un mot.

Ces fichiers sont versionnés, comme ceux de [`../hello/`](../hello/) : ce sont
des sources de quelques lignes, pas des données dérivées. Ils sont fautifs
volontairement, et le restent — les étudiants travaillent sur leur copie, ou
annulent leurs corrections en fin de séance.

## Les trois fautes

| Fichier | Faute | Ce que dit le message |
|---|---|---|
| `python/surface.py` | ligne 5 indentée par quatre espaces, ligne 6 par une tabulation | `TabError: inconsistent use of tabs and spaces in indentation`, ligne 6 |
| `python/moyenne.py` | deux-points manquants après le `for` | `SyntaxError: expected ':'`, ligne 6, avec un `^` sous la fin de la ligne |
| `cpp/aire.cpp` | point-virgule manquant en fin de ligne 6 | `error: expected ',' or ';' before 'std'`, **ligne 7** |

Les messages ci-dessus ont été obtenus sur le poste de préparation, avec Python
3.12 et g++ 11.4.

La troisième ligne est celle qui mérite le commentaire : g++ signale la ligne 7,
alors que le point-virgule manque à la ligne 6. Un compilateur signale l'endroit
où il ne peut plus continuer, pas l'endroit de la faute. C'est une habitude de
lecture à prendre tout de suite, et la raison pour laquelle le soulignement de
l'éditeur, qui porte sur la bonne ligne, vaut la peine d'être installé.

La première est la seule qui ne se voie pas à l'œil : les deux lignes sont
alignées à l'écran et diffèrent dans le fichier. Il faut l'affichage des
espaces, Affichage → Rendu des espaces → Tout, pour distinguer le point de la
flèche.

## Déroulé

```bash
conda activate info01
cd data/cours1/erreurs

python python/surface.py            # TabError
python python/moyenne.py            # SyntaxError
g++ cpp/aire.cpp -o cpp/aire        # error: expected ',' or ';'
```

Une fois les trois fichiers corrigés, les mêmes commandes affichent `294.0`,
`130.05` et, après `cpp/aire`, `294`. La vérification est là : le programme se
lance et ne dit plus rien.

## Sous Windows

`g++` n'est pas fourni avec Windows, comme pour la manipulation
[`../hello/`](../hello/) : le fichier C++ se lit et se corrige dans l'éditeur,
mais ne se compile que sur un poste équipé. Les deux fichiers Python, eux, se
lancent partout une fois l'environnement `info01` actif.

## Ce qui n'est pas versionné

L'exécutable `cpp/aire`, produit par la compilation une fois la faute corrigée.
