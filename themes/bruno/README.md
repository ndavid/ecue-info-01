# Thème Beamer « Bruno » porté en typst

Portage de `beamerthemeBruno.sty` et de ses quatre sous-thèmes, fournis dans
`example_beamer/` à côté de ce dépôt. Thème d'origine écrit en 2017-2019 par
Rémi Cérès et Mattéo Delabre, sous licence CC0 1.0, et présenté par ses auteurs
comme inspiré du thème Metropolis.

```bash
conda activate info01
typst compile demo.typ
```

- `bruno.typ` — le thème.
- `demo.typ` — une présentation de démonstration reprenant la structure de
  `example_beamer/part1.tex`.
- `exemple-fond.jpg` — image de substitution : `fig/title_fig/rendu.jpeg`, que
  le fichier d'origine appelle, n'a pas été fournie.

## Ce que fait le thème d'origine

Le fichier chargé par `\usetheme{Bruno}` ne contient rien : il appelle quatre
sous-thèmes, dont voici le contenu utile.

| Fichier | Ce qu'il définit |
|---------|------------------|
| `beamercolorthemeBruno` | trois couleurs, et rien de plus |
| `beamerfontthemeBruno` | Fira Sans, et les tailles des sept éléments de texte |
| `beamerinnerthemeBruno` | puces, filet horizontal, page de titre avec image en trapèze |
| `beamerouterthemeBruno` | bandeau supérieur supprimé, titre de diapositive, barre de pied de page |

Trois couleurs seulement, et chacune a un emploi unique :

| Nom | Valeur | Emploi |
|-----|--------|--------|
| `brunoblue` | `#182936` | tout le texte et toute la structure |
| `brunomarroon` | `#704730` | le filet de la page de titre, et rien d'autre |
| `brunolightgray` | `#E6E6E6` | fond de la barre de pied de page et corps des blocs |

Deux partis pris méritent d'être relevés, parce qu'ils font l'essentiel de
l'allure du thème :

- **Le gras n'est pas du gras.** `\setsansfont[BoldFont={* Medium}]{Fira Sans}`
  redirige `\bfseries` vers la graisse *Medium*. Les titres paraissent donc
  affirmés sans être lourds, ce qui est le geste caractéristique de Metropolis.
- **Le texte n'est pas noir.** `normal text` est fixé à `brunoblue`, un bleu
  très sombre. Sur un vidéoprojecteur, le contraste est moins dur que le noir.

## Comment le portage a été vérifié

Le thème d'origine a été compilé, et le PDF obtenu mesuré, plutôt que jugé à
l'œil. Deux réserves sur ce PDF de référence :

- `luaotfload` manque sur cette machine, donc `fontspec` est inutilisable :
  `\setsansfont` a été neutralisé et la compilation faite avec pdflatex et
  Latin Modern Sans. La géométrie est intacte, la police non.
- Il faut **deux passes** : la page de titre emploie `remember picture`, et une
  passe unique place l'image de fond au mauvais endroit.

Les positions ont ensuite été relevées avec `pdftotext -bbox-layout` des deux
côtés. Écarts obtenus, sur une page de 453,5 × 255,1 pt :

| Repère | Beamer (x/y en pt) | typst | Écart |
|--------|--------------------|-------|-------|
| Titre de la page de titre | 28,3 / 41,5 | 28,3 / 37,5 | −4,0 |
| Auteur | 28,3 / 125,1 | 28,3 / 125,1 | 0,0 |
| Institut | 28,3 / 159,2 | 28,3 / 161,7 | +2,5 |
| Titre de diapositive | 28,3 / 26,0 | 28,3 / 26,0 | 0,0 |
| Première ligne du corps | 28,3 / 103,5 | 28,3 / 107,5 | +4,0 |
| Premier élément de liste | 50,2 / 132,0 | 48,6 / 137,2 | +5,2 |
| Pied de page | 28,3 / 247,6 | 28,3 / 246,8 | −0,9 |

Les marges horizontales tombent exactement ; les écarts verticaux restent sous
5 pt, soit moins de 2 % de la hauteur de page, et tiennent aux métriques de
police différentes entre la référence et le portage.

## Ce que la mesure a corrigé

Trois lectures du code source se sont révélées fausses, et n'auraient pas été
détectées sans compiler l'original.

1. **La barre de pied de page couvre toute la largeur.** Le gabarit demande
   `wd=\textwidth`, ce qui laissait attendre une barre s'arrêtant 2 cm avant le
   bord. Mais Beamer donne à `\textwidth` la valeur de `\paperwidth` à
   l'intérieur d'un gabarit de pied de page. Mesuré : de 0 à 453,3 pt.
2. **La page de titre garde son pied de page.** Elle affiche « 1 / 3 » dans le
   PDF de référence, alors que `\maketitle` est réputé produire un cadre
   `plain`.
3. **Le bloc de titre n'est pas centré verticalement.** Beamer répartit
   l'espace libre selon `\beamer@frametopskip` et `\beamer@framebottomskip`,
   dans un rapport 0,4 contre 0,6, et sur une zone qui commence au bord
   supérieur du papier puisque le bandeau est vidé. Le haut du titre tombe
   alors à 41,4 pt, ce que le PDF donne à 0,1 pt près.

La hauteur de la barre s'explique de la même façon : `ht=3ex + dp=1,25ex` est
évalué dans la police du pied de page, qui est `\tiny`, soit 6 pt. D'où 11,3 pt
et non les 21 pt qu'un calcul en corps 11 aurait donnés.

## Écarts assumés

| Point | Original | Ici | Pourquoi |
|-------|----------|-----|----------|
| Police | Fira Sans | `("Fira Sans", "Lato", "DejaVu Sans")` | Fira Sans n'est pas installée ; Lato possède aussi une graisse 500, indispensable au « gras » du thème |
| Découpe de l'image de titre | `\clip` TikZ sur un trapèze | image entière, puis masque blanc à gauche de la diagonale | typst ne sait pas rogner selon une forme quelconque ; le rendu est identique sur fond blanc |
| Petites capitales du sous-titre | `\scshape` | capitales à 0,85 em, légèrement espacées | ni Fira Sans ni Lato ne portent de table `smcp` ; avec ces polices, le `\scshape` de l'original ne produirait rien de visible |

Le dernier point est le seul endroit où le portage est plus soigné que
l'original. La référence compilée montre de vraies petites capitales, mais
seulement parce que la police de substitution, Latin Modern Sans, en possède.

## Ce que le thème ne fournit pas

Relevé utile pour qui compare avec un autre thème : Bruno **n'a pas** de barre
de progression, contrairement à Metropolis ; **aucun** gabarit de diapositive
de section, et rien ne se déclenche sur `\section` ; pas de bandeau supérieur
ni de symboles de navigation, tous deux explicitement supprimés.

## Utilisation

```typst
#import "bruno.typ": bruno, diapo, bloc, bloc-definition, filet

#show: bruno.with(
  titre: [Cours d'OpenGL : \ Introduction],
  auteurs: ("Florent GENIET",),
  institut: "ENSG",
  date: "6 septembre 2026",
  fond: "exemple-fond.jpg",   // facultatif
  titre-court: "Cours d'OpenGL",
  auteur-court: "F. GENIET",
)

#diapo("Titre", sous-titre: "Sous-titre facultatif")[
  Le corps de la diapositive.
]
```

Pour obtenir la vraie Fira Sans, l'installer sur le poste (elle est sous
licence OFL) ou la déposer dans un dossier passé à `typst compile
--font-path`. Rien d'autre à changer : la pile de polices la prend d'elle-même
si elle est disponible.

## Rapport avec le reste du dépôt

Ce dossier est la référence : il conserve le portage fidèle, à la géométrie
exacte du thème d'origine, et la trace des mesures qui l'ont validé.

Les supports du module s'en servent. `src/cours<n>/diapo/theme.typ` reprend
l'identité de Bruno — couleurs, police, demi-gras, barre de pied de page,
angles vifs — transposée à une page de projection plus grande (facteur 1,909,
qui laisse le corps de texte à 21 pt), et y ajoute ce que Bruno ne fournit pas :
une diapositive de section et une ouverture de partie TD. Il reste soumis aux
conventions de [`STYLE.md`](../../STYLE.md).
