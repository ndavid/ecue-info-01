# Diapositives — Cours 1

Pour relire les sources sans connaître typst :
[`src/commun/typst-101.md`](../../commun/typst-101.md), qui commente ligne à
ligne les deux premières diapositives de l'ouverture.

Structure **assertion-evidence** : le titre nomme le sujet de la diapositive,
une phrase d'annonce énonce l'idée, et le corps est une preuve visuelle
(schéma, sortie de commande, comparaison). Aucune liste à puces. Les
conventions et leurs sources sont dans [`STYLE.md`](../../../STYLE.md).

Avant la première compilation, installer Fira Sans — voir
[`INSTALLATION.md`](../../../INSTALLATION.md), section 3 :

```bash
python outils/verifier_polices.py --installer
```

Le plus simple ensuite est de passer par le script de compilation, qui met
`--root` sur la racine du dépôt et emploie les captures d'écran si elles sont
présentes :

```bash
python outils/compiler_diapos.py                  # à projeter
python outils/compiler_diapos.py --notes          # version annotée
python outils/compiler_diapos.py --corrige        # corrigé des manipulations
python outils/compiler_manips.py                 # une feuille par manipulation
```

`cours1.pdf` est la séance elle-même, 101 pages : c'est ce qu'on projette. Les
options se combinent : `--notes --corrige` produit `cours1-notes-corrige.pdf`.

L'exposé et les manipulations sont dans deux dossiers, `parties/` et `manips/`,
et un fichier par manipulation. Deux compilations en découlent : `--input
manips=false` donne le seul fil du cours, 61 pages, pour le relire sans les
gestes ; et `outils/compiler_manips.py` compile chaque manipulation seule, en
feuille d'instructions déposée dans le dossier de données qu'elle annonce, sous
le nom `instructions-<nom>.pdf`. C'est le même fichier source dans les deux
cas : ce qui est projeté et ce que l'étudiant garde sous les yeux ne peuvent
pas diverger.

Les commandes équivalentes, à la main :

```bash
conda activate info01

# diapositives seules
typst compile --root . src/cours1/diapo/cours1.typ

# version avec les notes de conduite, pour l'enseignant
typst compile --root . --input notes=true src/cours1/diapo/cours1.typ cours1-notes.pdf

# avec les captures d'écran, si l'archive a été décompressée dans data/
typst compile --root . --input captures=true src/cours1/diapo/cours1.typ

# le seul fil du cours, sans les manipulations
typst compile --root . --input manips=false src/cours1/diapo/cours1.typ cours1-sans-manips.pdf

# corrigé des manipulations, à distribuer après la séance
typst compile --root . --input corrige=true src/cours1/diapo/cours1.typ cours1-corrige.pdf

# recompilation à chaque sauvegarde
typst watch --root . src/cours1/diapo/cours1.typ
```

`--root .`, depuis la racine du dépôt, autorise typst à lire les images de
`data/` ; sans cette option il refuse de sortir de `src/cours1/diapo/`.

## Organisation des fichiers

Le contenu est découpé, une partie de la séance par fichier. `cours1.typ` ne
porte plus que les réglages globaux et l'ordre des parties : les règles `#show`
qu'il pose s'appliquent à tout ce qui est inclus ensuite.

```
src/commun/theme.typ        mise en page, couleurs, polices et gabarits
src/commun/schemas.typ      bloc, etape, chaine, couche, liaison, frise
src/commun/prelude.typ      ré-exporte les deux, seul import à écrire
src/cours1/diapo/cours1.typ assemblage : réglages, puis les #include
src/cours1/diapo/parties/   l'exposé : 00 ouverture, puis 01 à 05
src/cours1/diapo/manips/    les manipulations, une par fichier
```

Un fichier inclus par `#include` **n'hérite pas** des imports de celui qui
l'inclut : chaque partie porte donc sa propre ligne
`#import "../../../commun/prelude.typ": *`. C'est le seul boilerplate, et le
prelude le réduit à une ligne quel que soit le nombre de gabarits.

Les images se désignent depuis la racine du projet, `"/data/cours1/…"` : typst
résout un chemin relatif par rapport au fichier où `image` est appelé,
c'est-à-dire au thème, et non par rapport au fichier qui écrit le chemin.

`cours1.typ` produit 100 pages avec les captures d'écran : titre, introduction
au module, le contenu de la séance, puis ses cinq parties (logiciels et formats
de fichier, programmation et éditeur de code, environnement de programmation,
notebooks, markdown et les autres fichiers texte).

## Identité visuelle

Le thème reprend celle du thème Beamer **Bruno** (Rémi Cérès et Mattéo
Delabre, CC0), analysée et portée dans [`themes/bruno/`](../../../themes/bruno/),
puis transposée à une page de projection plus grande en conservant les rapports
d'origine. Trois couleurs, chacune à emploi unique :

| Couleur | Valeur | Emploi |
|---------|--------|--------|
| `accent` | `#182936` | tout le texte, les titres, la structure |
| `manip` | `#704730` | le filet de la page de titre, et le fond des parties TD |
| `gris` | `#E6E6E6` | la barre de pied de page, les encadrés, les blocs |

Deux partis pris viennent de Bruno : le texte n'est pas noir mais bleu très
sombre, moins dur au vidéoprojecteur ; et le « gras » est en réalité un
demi-gras (graisse 500), ce qui affirme les titres sans les alourdir.

La police est Fira Sans, installée par `outils/verifier_polices.py`. À défaut,
typst prend la suivante de la pile (Lato, qui possède aussi une graisse 500,
puis DejaVu Sans) : le document compile, mais plus large que ce pour quoi les
gabarits ont été réglés. Les angles sont vifs partout : le thème d'origine
n'arrondit jamais.

## Gabarits

| Gabarit | Rôle |
|---------|------|
| `separateur-module(titre, annonce:, auteur:, date:)` | couverture du module, fond bleu |
| `page-titre(titre:, sous-titre:, auteur:, date:, fond:)` | page de titre d'une séance, posée où on la veut |
| `d(titre, sous-titre: none)` | une diapositive ordinaire |
| `separateur(titre, annonce:)` | diapositive de section, fond bleu |
| `separateur-td(titre, annonce:, mention:)` | ouverture d'une partie de travaux dirigés, fond brun |
| `separateur-reprise(titre, annonce:)` | retour à l'exposé après une manipulation en milieu de partie |
| `separateur-manip(titre, annonce:)` | même gabarit, mention « Manipulation » |

Les trois derniers marquent le passage de l'exposé au travail sur machine, et son retour, la
distinction 🎓 / ⌨️ du syllabus. C'est la seule information que la couleur
code, et elle ne sert à rien d'autre. Bruno ne fournit ni l'un ni l'autre :
ces deux gabarits sont ajoutés ici, en n'employant que les couleurs du thème.

## Éléments

`annonce` (la phrase sous le titre), `notes` (ce que l'enseignant dit et qui
n'est pas projeté), `legende`, `tableau`, `face-a-face`, `panneau`, `question`
(posée à la salle), `etiquette` (une extension dans une grille de
reconnaissance), `bloc-titre` (le bloc Beamer, bandeau bleu sur corps gris),
`fenetre` (une fenêtre d'application dessinée), `illustration` (une capture d'écran quand elle est
disponible, un dessin sinon), et trois pictogrammes vectoriels
`icone-fenetre`, `icone-engrenage`, `icone-puce`.

`tableau` porte tout le style des tableaux, et les diapositives ne passent que
le contenu, les colonnes et l'alignement : corps réduit d'un cran par rapport
au texte courant, filet entre les colonnes, ligne d'en-tête en demi-gras sur
fond très clair et soulignée d'un filet plus marqué. `entete: false` pour un
tableau dont la première ligne est déjà une donnée.

Les pictogrammes sont dessinés avec les primitives de typst (`rect`, `circle`,
`rotate`) : pas de police d'icônes ni d'image importée, donc rien à installer
et un rendu identique partout.

Aucun paquet typst importé. La seule dépendance est la police du texte : sa
pile de substitution garantit que le document compile partout, mais la mise en
page n'est celle qui est visée qu'avec Fira Sans.

## Schémas et hauteurs de boîtes

Une hauteur de boîte écrite à la main dépend de la police effectivement
présente sur le poste, et c'est ainsi que du texte est passé par-dessus le bord
de ses cadres quand Fira Sans manquait. Les schémas en chaîne emploient donc
`chaine(…)`, défini dans `src/commun/schemas.typ` : il mesure les boîtes à la largeur
qu'elles occuperont, retient la plus haute, et impose cette hauteur à toutes.
Le résultat tient même compilé avec `--ignore-system-fonts`.

## Manipulations et corrigé

Ce qu'une manipulation fait constater n'est pas écrit sur la diapositive
projetée : les colonnes d'observation sont remplacées par un filet à compléter,
et `--input corrige=true` les remplit. Le gabarit est `reponse[…]`, et il
s'applique aux colonnes « Ce qui se passe », « Ce que vous constatez »,
« Le texte est-il encore du texte ? » et « Résultat observé ».

Ce n'est pas une coquetterie de mise en page. Tenter avant de voir la réponse
améliore la rétention de celle-ci, même quand la tentative échoue, et un
support à trous est plus efficace qu'un support complet. Les références sont
dans [`STYLE.md`](../../../STYLE.md).

## Vérifier une fois compilé

```bash
python outils/verifier_diapos.py src/cours1/diapo/cours1.pdf
```

Le gabarit `d` répartit l'espace libre entre le titre et le bas de page par
deux ressorts. Quand le corps est trop haut, ces ressorts se referment sans
que typst ne dise rien : l'annonce vient se coller sous le titre. Le script
mesure cet écart page par page et signale ce qui passe sous le seuil.

La version annotée se relit au même seuil, et doit rendre le même verdict : ses
notes ne sont pas prises sur la diapositive mais posées à côté, si bien que les
deux variantes ont exactement la même zone de diapositive. Leurs nombres de
pages doivent donc être égaux ; un écart signifie qu'une diapositive déborde sur
une page de suite. Le script ne mesure que la moitié gauche d'une page double,
faute de quoi il lirait les lignes de notes comme le corps.

## La version annotée

`--input notes=true` produit une page **deux fois plus large** : la diapositive
à gauche, ses notes de conduite à droite. C'est le format « second écran » de
Beamer, `show notes on second screen`.

Étirée sur un bureau étendu à deux écrans, la moitié gauche part au
vidéoprojecteur et la moitié droite reste sur l'écran du présentateur. Lue à
plat ou imprimée, elle donne la diapositive et ses notes côte à côte.

La moitié gauche est **au millimètre celle qui est projetée** : les marges de
droite absorbent toute la seconde moitié, et le fond plein des diapositives de
séparation comme la barre de pied s'y arrêtent. Vérifié mot pour mot, aux mêmes
coordonnées, sur les 94 pages.

Aucun format de PDF ne distingue une note d'un contenu de page : ce que le
lecteur affiche, il l'affiche en entier, et aucun lecteur Windows courant ne
sait masquer la moitié droite. Cette version n'est donc pas projetable telle
quelle — c'est `cours<n>.pdf`, sans notes, qui va au vidéoprojecteur. À défaut
de bureau étendu, ouvrir les deux fichiers côte à côte : ils ont le même nombre
de pages, page pour page.

## Illustrations

`illustration(chemin, repli)` affiche la capture d'écran désignée quand le
document est compilé avec `--input captures=true`, et le contenu de `repli`
sinon. Les captures vivent hors dépôt, dans `illustrations/cours1/` ;
leurs noms, leur format et leur poids maximal sont fixés par le
[README de ce dossier](../../../illustrations/cours1/README.md).

Une capture ne se justifie que pour montrer ce qu'un schéma ne peut pas dire,
comme l'aspect réel d'une interface. Partout ailleurs, le dessin vectoriel est
préféré : rien à distribuer, rien à refaire quand le logiciel change de
version, et un rendu identique sur tous les postes.
