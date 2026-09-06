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

## Diapositives

La structure suit le modèle *assertion-evidence* de Michael Alley (Penn State),
validé expérimentalement : à discours identique, un auditoire retient mieux une
diapositive portant une idée et une preuve visuelle qu'une liste à puces.
Le titre, en revanche, reste **descriptif** — un groupe nominal, pas une
assertion compressée.

**Quatre règles :**

1. **Le titre nomme le sujet de la diapositive.** « Extension et contenu »,
   « Le système d'exploitation », « Contenu de la séance ». Pas de slogan, pas
   de tournure à contraste (« X, pas Y »), pas de formule qui cherche l'effet.
2. **Une phrase d'annonce sous le titre** (`#annonce[…]`) énonce l'idée quand
   elle ne se lit pas d'elle-même sur la preuve. Une à deux phrases, au
   présent, sans emphase.
3. **Le corps est une preuve visuelle** : un schéma, une sortie de commande, un
   extrait de code, une comparaison. Pas de liste à puces.
4. **Ce que l'enseignant dit n'est pas écrit** (principe de redondance de
   Mayer : texte affiché plus même texte prononcé dégrade l'apprentissage). Le
   commentaire va dans `#notes[…]`, visible avec `--input notes=true`.

**Conséquences pratiques :**

- Une idée par diapositive. Un titre contenant « et » qui relie deux sujets
  distincts signale qu'il en faut deux.
- Une énumération de cinq items est le signe qu'il manque un schéma ou un
  tableau.
- Un tableau de comparaison est une preuve visuelle : il est légitime quand la
  comparaison est le propos.
- Des diapositives de séparation (`#separateur(…)`) marquent le passage d'une
  partie à l'autre.
- Principe de cohérence (Mayer) : tout élément qui ne sert pas nuit. Pas
  d'emoji décoratif, pas de couleur qui ne code rien. Le thème n'emploie que
  trois couleurs : le bleu du texte et des diapositives de section, le brun des
  parties TD et des manipulations (`separateur-td`, `separateur-manip`), et le
  gris des encadrés. Le brun code une information réelle et répétée, le passage
  de l'exposé au travail sur machine.

**Formulations à éviter**, relevées sur une première version de ce deck :

| Écrit | À écrire |
|-------|----------|
| « Ce module enseigne les gestes que les autres cours supposent acquis » | Titre : « Objectif du cours ». Annonce : « Consolider ou acquérir les bases informatiques nécessaires aux autres enseignements. » |
| « Ce module traite la forme des projets, pas l'algorithmique » | Titre : « Objectif pour la programmation », suivi de ce que cela recouvre. |
| « La séance répond à quatre questions qui s'enchaînent » | « Contenu de la séance » |
| « Un `.odt` est une archive ZIP de fichiers XML » | Titre : « Structure d'un fichier `.odt` ». L'affirmation passe en annonce. |

Les titres des sections des pages de cours suivent la même règle, pour que les
deux supports se répondent.

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
