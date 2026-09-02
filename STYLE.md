# Conventions d'écriture du dépôt

Ce document fixe la façon d'écrire les supports. Il existe parce que la première
version des supports était mal écrite : phrases-choc isolées, gras décoratif,
faux suspense, et des diapositives qui n'étaient que de la prose découpée en
puces. Les règles ci-dessous sont contraignantes.

## Trois registres, trois médias

Un même contenu ne s'écrit pas pareil selon qui le lit et quand.

| Fichier | Lu par | Lu quand | Registre |
|---------|--------|----------|----------|
| `src/cours<n>/diapo/` | l'étudiant, projeté | pendant que l'enseignant parle | **assertion + preuve visuelle**, texte minimal |
| `src/cours<n>/notebook/` | l'étudiant, seul | pendant la manipulation, et après | **prose autonome**, phrases complètes |
| `syllabus/cours/<n>/` | l'enseignant | à la préparation | **notes de conduite**, télégraphique assumé |

L'erreur à ne pas refaire : écrire les diapositives comme la page de cours.

## Diapositives : assertion-evidence

Le modèle est celui de Michael Alley (Penn State), validé expérimentalement :
à discours identique, l'auditoire qui voit des diapositives assertion-evidence
comprend et retient mieux que celui qui voit des listes à puces.

**Trois règles :**

1. **Le titre de la diapositive est une phrase complète** qui énonce ce que la
   diapositive démontre — pas un thème.
   *Pas* « Formats & extensions », mais « L'extension ne change pas le contenu
   du fichier ».
2. **Le corps est une preuve visuelle** : un schéma, une sortie de commande, un
   extrait de code, une comparaison. Pas une liste à puces.
3. **Les phrases d'explication se disent, elles ne s'écrivent pas.** Ce que
   l'enseignant va prononcer n'a pas à figurer à l'écran (principe de redondance
   de Mayer : texte à l'écran + même texte dit à voix haute dégrade
   l'apprentissage).

**Conséquences pratiques :**

- Une idée par diapositive. Si le titre contient « et », il y a deux diapositives.
- Pas de liste à puces. Une énumération de 5 items est le signe qu'il manque un
  schéma ou un tableau.
- Un tableau de comparaison **est** une preuve visuelle : il est autorisé quand
  la comparaison est le propos.
- Le texte de commentaire va en **notes de présentation** (`#notes[…]`), pas sur
  la diapositive.
- Principe de cohérence (Mayer) : tout élément qui n'est pas nécessaire nuit.
  Pas d'emoji décoratif, pas de couleur qui ne code rien, pas de « fun fact ».

## Prose (pages de cours, syllabus, README)

La page de cours est lue sans commentaire oral : elle doit se suffire. Elle
s'écrit donc en **phrases complètes et déclaratives**.

**À faire**

- Annoncer ce dont on parle, puis le dire. Pas de suspense.
- Une idée par paragraphe, 3 à 6 lignes.
- Justifier les choix quand ils ne vont pas de soi ; ne pas justifier l'évident.
- Employer le mot technique dès qu'il a été défini, plutôt que des périphrases.

**À proscrire** (relevé sur la première version de ce dépôt)

| Tic | Exemple produit | Correction |
|-----|-----------------|------------|
| Phrase-choc isolée en paragraphe | « Rien de plus. » / « C'est tout. » | l'intégrer à la phrase précédente |
| Faux suspense | « Voilà l'idée centrale, et elle surprend souvent » | énoncer l'idée directement |
| Gras décoratif | trois mots en gras par paragraphe | le gras signale un terme défini, rien d'autre |
| Formule répétée | « Ce que ça montre : » dans chaque encadré | varier, ou supprimer si l'exercice le dit déjà |
| Tiret cadratin en connecteur | « le fichier — celui qu'on ouvre — est binaire » | virgules, parenthèses, ou deux phrases |
| Méta-commentaire pédagogique | « le moment "ah !" de la séance » | réservé aux notes enseignant |
| Auto-annonce | « Voilà pourquoi c'est important » | le montrer, ne pas l'annoncer |
| Emoji comme structure | ✅ ❌ ⚠️ en début de ligne | des mots, ou un tableau |
| Triplets systématiques | tout par groupes de trois | suivre le contenu, pas le rythme |

**Sur les émoji** : `🎓` et `⌨️` sont conservés dans le *syllabus* et les notes
enseignant, où ils codent une information réelle (exposé / manipulation) et
répétée. Ailleurs, ils sont décoratifs — donc supprimés.

## Encadrés

Un encadré n'est pas un moyen de mettre du texte en valeur. Il signale un
changement de nature du contenu :

| Encadré | Contenu |
|---------|---------|
| `:::{admonition} Manipulation` | ce que l'étudiant doit faire, à l'impératif |
| `:::{note}` | une précision qu'on peut sauter en première lecture |
| `:::{warning}` | une erreur fréquente et ses conséquences |

Pas d'encadré « à retenir » qui recopie le paragraphe précédent.

## Code et sorties

- Tout extrait de code affiché doit être exécutable tel quel.
- Les sorties montrées sont des sorties réelles, pas reconstituées.
- Un extrait de plus de 15 lignes va dans un fichier, pas dans la page.

## Vérification avant de committer un support

- [ ] Chaque titre de diapositive est une phrase complète.
- [ ] Aucune diapositive ne contient de liste à puces.
- [ ] Aucun paragraphe d'une seule phrase courte destiné à faire effet.
- [ ] Le gras ne marque que des termes définis.
- [ ] Aucun encadré ne répète le paragraphe voisin.
- [ ] Les commandes montrées ont été exécutées.

## Sources

- Michael Alley, *The Craft of Scientific Presentations* — structure
  assertion-evidence : [writing.engr.psu.edu/research.html](https://writing.engr.psu.edu/research.html)
  et le [jeu d'instructions Penn State](https://cpb-us-e1.wpmucdn.com/sites.psu.edu/dist/7/13153/files/2008/10/Assertion-Evidence-Slides-Instruction_Set.pdf)
- Richard Mayer, principes de cohérence, de signalement et de redondance :
  [synthèse](https://www.hartford.edu/faculty-staff/faculty/fcld/_files/12%20Principles%20of%20Multimedia%20Learning.pdf)
- Synthèse des études comparatives :
  [scottjallen.net/sjablog/assertion-evidence](https://www.scottjallen.net/sjablog/assertion-evidence)
