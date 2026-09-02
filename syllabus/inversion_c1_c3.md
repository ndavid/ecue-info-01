# Note d'analyse — inversion partielle des cours 1 et 3

> Décidée et appliquée dans le [syllabus v2](01_syllabus_v1.md). Ce document garde
> la trace du *pourquoi*, des variantes écartées et des points à surveiller.

## Le déclencheur

Contrainte externe : **les autres cours du programme mobilisent Python avant la
semaine 3**. Dans le découpage v1, l'environnement conda n'était installé qu'en
séance 3 (29/09) — les étudiants arrivaient donc dans ces cours sans outillage
fonctionnel, et l'installation y était improvisée.

## Ce qui a été échangé

| | v1 | v2 |
|---|---|---|
| **Cours 1** | formats + **binaire/hexa/PGM** + IDE | logiciel/programmation + formats + IDE + **env. conda** + **notebooks** |
| **Cours 3** | **conda** + `pathlib`/`subprocess`/`argparse` | **binaire/hexa/PGM** + `pathlib`/`subprocess`/`argparse` |

Ajout net : un bloc **notebooks** (noyau, ordre d'exécution, `.ipynb` vs MyST),
qui n'existait qu'en « optionnel » dans le contenu détaillé v1.

## Pourquoi ça tient pédagogiquement

**Le binaire est mieux placé en séance 3.** En v1, le bloc PGM/hexadécimal
arrivait très tôt, sans usage immédiat : les étudiants regardaient des octets
sans savoir quoi en faire. En séance 3, il précède directement `pathlib` (lire
des octets), puis `numpy` (cours 6) et le benchmark image (TD7) — « une image est
un tableau de nombres » devient une information *dont on se sert la séance
suivante*.

**Les formats texte suffisent à motiver la séance 1.** La progression devient
linéaire et sans trou : *un logiciel* → *programmer, c'est écrire du texte* →
*donc : dans quel fichier, sous quelle forme ?* → `.txt` / `.odt` / `.html` /
CSS → *et avec quels outils ?* → IDE + environnement + notebooks. Le binaire
n'est pas nécessaire à cet enchaînement ; il l'interrompait plutôt.

**La séance 1 gagne en cohérence de fin.** Terminer sur « votre environnement
est prêt, et voici comment un notebook exécute votre code » donne un résultat
tangible et immédiatement réutilisable ailleurs. Terminer sur l'hexadécimal ne
produisait rien d'exploitable.

**Le bloc notebooks reboucle sur la leçon du jour.** `.ipynb` (JSON, résultats
inclus, `diff` illisible) contre MyST (Markdown, `diff` lisible) est *exactement*
la question « même contenu, deux formats » vue une heure plus tôt sur
`.txt`/`.odt`/`.html` — mais appliquée au travail des étudiants eux-mêmes. Et
elle amorce le cours 2 (pourquoi le texte se versionne bien).

## Densité : le vrai risque

La v1 signalait déjà une séance 1 surchargée (~107′ de contenu). La v2 ne
l'allège pas mécaniquement.

| Séance 1 v2 | Durée |
|---|---|
| Logiciel (haut niveau) | 12′ |
| Programmer / interprété vs compilé | 10′ |
| Formats & extensions, fichiers cachés | 10′ |
| ⌨️ Un texte, quatre formes | 30′ |
| IDE (VSCode) | 8′ |
| ⌨️ Environnement conda | 25′ |
| Notebooks | 10′ |
| ⌨️ Dépôt de notes | 10′ |
| **Total** | **115′** |

**Leviers d'ajustement, dans cet ordre :**

1. **Installer conda en amont** (consigne avant la rentrée + créneau d'assistance).
   La manipulation en séance retombe alors à ~10′ de vérification. C'est le
   levier le plus efficace : l'installation est ce qui déborde le plus, et ce qui
   dépend le plus des postes.
2. **Basculer la partie ODT-comme-ZIP en exercice complémentaire** (−8′).
3. **Réduire « un texte, quatre formes » à trois formes** en séance (le HTML+CSS
   passe en autonomie, −8′).

Le bloc notebooks est *conservé quoi qu'il arrive* : c'est lui qui justifie le
déplacement.

## Variantes écartées

**Tout laisser en place, ne remonter que conda en fin de séance 1.** Rejetée :
la séance 1 passait à ~130′ et l'installation, placée en fin de créneau, est
justement ce qui déborde. Aucun allègement en compensation.

**Déplacer conda en séance 2.** Rejetée : la séance 2 est déjà pleine (CLI + git
local + 40′ de manipulation guidée), et une semaine de retard ne résout qu'à
moitié la contrainte externe.

**Créer une séance 0 d'installation.** Séduisante mais hors budget : le module
fait 14 h fermes.

## Conséquences sur les autres séances

- **Cours 2** (CLI & git) : inchangé. Bénéficie même d'un environnement déjà
  installé (`pandoc`, `typst` disponibles pour la conversion de document).
- **Cours 3** : conserve `pathlib`/`subprocess`/`argparse` ; l'ancien créneau
  conda (20′) est repris par le bloc binaire (15′ + 20′ de manipulation), ce qui
  le densifie légèrement → surveiller, le mini-pipeline de 40′ est le premier à
  raboter.
- **Cours 6 / TD 7** : bénéficient d'un rappel binaire beaucoup plus frais
  (séance 3 au lieu de séance 1).
- **TD 4** : le prérequis « env conda prêt » est acquis depuis trois semaines au
  lieu d'une.

## À vérifier après la première exécution

- [ ] L'installation conda tient-elle en 25′ sur les postes du labo *et* sur les
      portables personnels ?
- [ ] La manipulation « un texte, quatre formes » tient-elle en 30′ ?
- [ ] Le bloc notebooks passe-t-il sans avoir vu `pathlib` (cours 3) ?
- [ ] Les étudiants retrouvent-ils leur environnement en séance 2 sans aide ?
