# Installer une bibliothèque et s'en servir — Cours 1

La partie 4 explique pourquoi on isole un environnement et quel outil
l'installe. Cette manipulation la termine en faisant le geste dont il a été
question : créer un environnement neuf, constater ce qu'il contient et ce qui
lui manque, ajouter la bibliothèque manquante, puis s'en servir tout de suite.

Le dossier est écrit comme un petit projet Python ordinaire, et non comme un
script isolé. C'est délibéré : les étudiants verront cette forme dans tous les
dépôts qu'ils ouvriront cette année, et elle porte la leçon de la partie — un
projet dit dans un fichier ce dont il a besoin.

```
environnement/
├── pyproject.toml     ce qu'est le projet, et ce dont il dépend
├── environment.yml    l'environnement conda dans lequel il tourne
├── README.md          ce fichier : l'installation et le déroulé
├── style.css          la présentation de la page produite
└── page_html/         le code
    ├── __init__.py    la conversion
    └── __main__.py    ce qui s'exécute
```

La page `recette.html` que le programme écrit n'est pas versionnée, non plus
que le `page_html.egg-info/` que dépose une installation en mode éditable : ce
sont des artefacts, comme le PDF du poème ou l'exécutable du « hello world ».

## Les deux fichiers de description, et ce qui les distingue

C'est le point que la manipulation fait toucher du doigt, et il vaut la peine
de le poser avant la séance.

| Fichier | Décrit | Employé par |
|---|---|---|
| `environment.yml` | l'environnement : la version de Python, et tout ce qu'il faut avoir sur la machine, y compris ce qui n'est pas du Python | `conda` |
| `pyproject.toml` | le projet : son nom, sa version, les bibliothèques Python que le code importe, et la commande qu'il installe | `pip`, et les outils de construction |

Aucun des deux n'installe quoi que ce soit. Ils disent ce qu'il faut installer,
et c'est précisément ce qui rend l'installation reproductible : elle ne repose
plus sur le souvenir de ce qu'on a tapé.

`environment.yml` est livré **sans** `markdown`, volontairement. L'ajouter est
la dernière étape du déroulé ci-dessous.

## Ce que la manipulation montre

Le programme reprend trois choses vues plus tôt dans la séance, et n'en
introduit aucune :

- le fichier `recette.md` est celui que les étudiants ont écrit à la
  manipulation Markdown de la partie 3 ;
- la page produite sépare le contenu (`recette.html`) de la présentation
  (`style.css`), comme les deux pages du poème de la partie 1 ;
- elle s'ouvre par une adresse `file:///`, sans serveur ni réseau.

Ce que la manipulation ajoute est le geste de la partie 4 : une bibliothèque
manque, on l'installe dans l'environnement actif, et le même programme qui
échouait passe.

`markdown` est aussi l'exemple de la diapositive « Ce qu'une bibliothèque
contient vraiment », colonne « tout en Python ». L'installation le vérifie :
aucun binaire compilé, la même chose sur les trois systèmes.

## Déroulé, geste par geste

Dans l'éditeur de code, dans cet ordre.

### Un environnement neuf

1. **Fichier → Ouvrir le dossier**, puis choisir `data/cours1/environnement/`.
2. Ouvrir `pyproject.toml` et lire la ligne `dependencies`. Le projet annonce
   avoir besoin de `markdown` **avant** qu'on ait lancé quoi que ce soit.
3. **Terminal → Nouveau terminal**, puis créer l'environnement décrit par le
   fichier voisin :

   ```bash
   conda env create -f environment.yml
   conda activate recette
   ```

   L'invite passe de `(info01)` à `(recette)`.

4. Regarder ce qu'un environnement « Python seul » contient :

   ```bash
   conda list
   ```

   **28 paquets**, dont une douzaine de bibliothèques C — `openssl`,
   `libsqlite`, `libzlib` — sans lesquelles l'interpréteur ne démarre pas.
   `pip`, `setuptools` et `wheel` y sont aussi : c'est pourquoi `pip install`
   fonctionne dans un environnement conda sans qu'on l'ait installé. Aucun
   paquet ne s'appelle `markdown`.

5. Lancer le programme. **Il s'arrête, et c'est voulu :**

   ```console
   $ python -m page_html
   Traceback (most recent call last):
     ...
     File ".../page_html/__init__.py", line 13, in <module>
       import markdown
   ModuleNotFoundError: No module named 'markdown'
   ```

   Le paquet est là, il se lit, sa syntaxe est correcte. Ce qui manque est le
   code qu'il réutilise, c'est-à-dire sa dépendance.

   `python -m page_html` exécute un *paquet* et non un fichier : le dossier
   `page_html/` en est un, et `-m` demande à Python de le lancer.

### L'installation

6. Installer la bibliothèque dans l'environnement actif :

   ```bash
   conda install -c conda-forge markdown
   ```

   **Trois paquets** s'installent : `markdown`, et deux qu'il réclame,
   `importlib-metadata` et `zipp`.

7. Relancer la même commande, inchangée :

   ```console
   $ python -m page_html
   recette.md -> recette.html, 1282 octets
   file:///.../data/cours1/environnement/recette.html
   ```

8. Ouvrir `recette.html` : double-clic dans l'arborescence, ou coller dans le
   navigateur l'adresse `file:///` que le programme affiche.
9. Changer une couleur dans `style.css`, enregistrer, recharger avec `F5`. Le
   HTML n'a pas bougé.

### Écrire ce qu'on vient d'installer

10. Ajouter `markdown` à `environment.yml`, sous `dependencies` :

    ```yaml
    dependencies:
      - python=3.12
      - markdown
    ```

11. Vérifier que le fichier décrit bien l'environnement obtenu :

    ```bash
    conda env update -f environment.yml
    ```

    Rien ne s'installe, puisque c'est déjà fait. Sur une machine neuve, en
    revanche, `conda env create` installera les deux d'un coup : l'installation
    faite à la main est devenue reproductible.

### Pour ceux qui vont vite

12. Installer le projet lui-même dans l'environnement :

    ```bash
    pip install -e .
    page-html
    ```

    La commande `page-html` existe désormais et fait la même chose que
    `python -m page_html`. C'est ce que déclare la section `[project.scripts]`
    de `pyproject.toml`. Construire une commande de cette forme est le sujet du
    cours 3.

### Rendre la main

```bash
conda deactivate
conda activate info01
```

L'environnement `recette` peut être gardé — il pèse peu — ou supprimé par
`conda env remove -n recette`.

## Ce qui a été mesuré

Relevé sur la machine de préparation, sous Linux, avec le solveur `libmamba` de
conda 24.7.

| Mesure | Valeur |
|---|---|
| `conda env create -f environment.yml` | 10 s, index des paquets déjà en cache |
| Paquets d'un environnement « Python seul » | 28 |
| `conda install markdown` dans cet environnement | 3 paquets, 7 s |
| La même commande dans `info01` (352 paquets) | 1 paquet, 85 ko, 1 min 52 s à froid |
| Version installée | `markdown` 3.10.3, canal conda-forge |
| Taille de `recette.html` | 1 282 octets |

Le contraste entre les deux avant-dernières lignes est le meilleur moment de la
manipulation : la même commande installe trois paquets dans un environnement
neuf et un seul dans `info01`, où `importlib-metadata` et `zipp` avaient déjà
été tirés par autre chose. Ce qui est déjà là ne se réinstalle pas.

> La durée dépend du réseau de la salle, et trente postes qui interrogent
> conda-forge en même temps ne vont pas aussi vite qu'un seul. Lancer
> l'installation puis commenter sa sortie pendant qu'elle tourne, plutôt que
> d'attendre en silence.

## Pourquoi `markdown` et pas `jinja2`

La première idée était de produire un `.odt` depuis un modèle, en substituant
le texte dans `content.xml` avec `jinja2`. Elle est écartée pour une raison
mesurée, pas de goût : **`jinja2` est déjà installé** dans `info01`, tiré comme
dépendance de Sphinx et de JupyterLab. `conda install jinja2` n'installerait
rien et afficherait `All requested packages already installed`, ce qui prive la
manipulation de son objet.

`markdown` est absent de l'environnement du module comme de l'environnement
neuf, et n'est la dépendance d'aucun de ses paquets : l'étape 5 du déroulé
échoue vraiment.

## Les tableaux et les blocs de code

`markdown.markdown()` seul ne traduit ni les tableaux ni les blocs de code :
ils ne font pas partie du Markdown que John Gruber a publié en 2004, et la
bibliothèque les traite en option. C'est le sens du second argument, dans
`page_html/__init__.py` :

```python
markdown.markdown(texte, extensions=["tables", "fenced_code"])
```

Le mot est malheureusement le troisième sens d'« extension » de la séance,
après la fin d'un nom de fichier et le greffon de l'éditeur. Ne pas s'y
attarder en séance : dire que le tableau des ingrédients demande une option, et
passer.

## Le diagramme, qui ne se dessine pas

Le bloc `mermaid` de `recette.md` arrive dans la page sous la forme de ses six
lignes de texte, encadrées, et non sous la forme d'un dessin. Ce n'est pas un
défaut de la conversion : Mermaid est un service de l'aperçu de l'éditeur, pas
du HTML. Le navigateur reçoit du texte et affiche du texte.

C'est la question à poser à la salle avant de répondre. Elle referme la
distinction tenue toute la séance entre ce que contient un fichier et ce qu'un
logiciel en affiche — déjà rencontrée avec la coloration syntaxique et avec la
police à chasse fixe.
