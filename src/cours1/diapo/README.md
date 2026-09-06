# Diapositives — Cours 1

Structure **assertion-evidence** : le titre de chaque diapositive est une phrase
complète énonçant ce qu'elle démontre, et le corps est une preuve visuelle
(schéma, sortie de commande, comparaison). Aucune liste à puces. Les
conventions et leurs sources sont dans [`STYLE.md`](../../../STYLE.md).

```bash
conda activate info01

# diapositives seules
typst compile src/cours1/diapo/cours1.typ

# version avec les notes de conduite, pour l'enseignant
typst compile --input notes=true src/cours1/diapo/cours1.typ cours1-notes.pdf

# recompilation à chaque sauvegarde
typst watch src/cours1/diapo/cours1.typ
```

- `theme.typ` — mise en page, couleurs, polices et gabarits.
- `cours1.typ` — 51 pages : titre, introduction au module, la séance en trois
  parties (logiciels et interfaces, programmation, formats de fichier et
  outils), puis les annexes.

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

La police est Fira Sans si elle est installée, Lato sinon — cette dernière
possède aussi une graisse 500. Les angles sont vifs partout : le thème
d'origine n'arrondit jamais.

## Gabarits

| Gabarit | Rôle |
|---------|------|
| `separateur-module(titre, annonce:, auteur:, date:)` | couverture du module, fond bleu |
| `page-titre(titre:, sous-titre:, auteur:, date:, fond:)` | page de titre d'une séance, posée où on la veut |
| `d(titre, sous-titre: none)` | une diapositive ordinaire |
| `separateur(titre, annonce:)` | diapositive de section, fond bleu |
| `separateur-td(titre, annonce:, mention:)` | ouverture d'une partie de travaux dirigés, fond brun |
| `separateur-manip(titre, annonce:)` | même gabarit, mention « Manipulation » |

Les deux derniers marquent le passage de l'exposé au travail sur machine, la
distinction 🎓 / ⌨️ du syllabus. C'est la seule information que la couleur
code, et elle ne sert à rien d'autre. Bruno ne fournit ni l'un ni l'autre :
ces deux gabarits sont ajoutés ici, en n'employant que les couleurs du thème.

## Éléments

`annonce` (la phrase sous le titre), `notes` (ce que l'enseignant dit et qui
n'est pas projeté), `legende`, `tableau`, `face-a-face`, `panneau`, `question`
(posée à la salle), `etiquette` (une extension dans une grille de
reconnaissance), `bloc-titre` (le bloc Beamer, bandeau bleu sur corps gris), et
trois pictogrammes vectoriels `icone-fenetre`, `icone-engrenage`, `icone-puce`.

`tableau` porte tout le style des tableaux, et les diapositives ne passent que
le contenu, les colonnes et l'alignement : corps réduit d'un cran par rapport
au texte courant, filet entre les colonnes, ligne d'en-tête en demi-gras sur
fond très clair et soulignée d'un filet plus marqué. `entete: false` pour un
tableau dont la première ligne est déjà une donnée.

Les pictogrammes sont dessinés avec les primitives de typst (`rect`, `circle`,
`rotate`) : pas de police d'icônes ni d'image importée, donc rien à installer
et un rendu identique partout.

Aucune dépendance externe : aucun paquet importé. La seule police non fournie
par typst est celle du texte, et sa pile de substitution garantit un rendu sur
tout poste.
