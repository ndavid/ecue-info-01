# Contenu détaillé (gabarit à remplir) — Cours 3 : Binaire, données & CLI

Vue d'ensemble : [../../01_syllabus_v1.md](../../01_syllabus_v1.md).
Inversion C1↔C3 : [../../inversion_c1_c3.md](../../inversion_c1_c3.md).

## Déroulé détaillé

_(à compléter : reprendre les parties du syllabus — 🎓 exposé / ⌨️ TD + durée indicative — puis détailler chaque point.)_

> ⚠️ **Reçu du cours 1 (v2)** : le bloc *binaire / hexadécimal / ASCII-Unicode* et le focus PGM ci-dessous, qui vivaient en séance 1. Ils précèdent désormais directement `pathlib`, puis `numpy` (c6) et le benchmark image (TD7).
> L'installation de l'environnement conda est faite en **séance 1** : ici, simple rappel d'activation (`conda activate info01`) et ajout de dépendances.

### 🎓 15′ — Binaire vs texte

- Encodage, bit et puissances de 2, hexadécimal (code couleur) ; ASCII et Unicode → `.txt`.
- Nom des symboles de programmation (`| { [ #` …).
- Rappel du cours 1 : « l'extension ne dit pas le contenu » — ici on va *regarder* le contenu.
- Petit script Python : liste de codes ASCII → fichier texte, et l'inverse ; écrire un symbole Unicode / emoji dans l'éditeur et observer le nombre d'octets.

## ⌨️ 20′ — Focus : Visualiser une image binaire en hexadécimal (PGM/PPM)

Objectif : rendre tangible « un fichier binaire = une suite d'octets » en **regardant** une image minuscule, et faire le lien texte ↔ binaire ↔ pixels (prépare le TD7).

**Pourquoi PGM/PPM (Netpbm) et pas PNG.** PNG est réaliste mais **compressé** (chunks + zlib) → illisible pour un débutant. Le format **Netpbm** est le plus simple qui existe : en-tête en clair, puis les pixels bruts. Il a une variante **ASCII** et une variante **binaire** du *même* contenu — idéal pour la leçon texte vs binaire.

- **Structure** : un « magic number » (`P2` = gris ASCII, `P5` = gris binaire ; `P3`/`P6` = couleur RGB), puis `largeur hauteur`, la valeur max (255), puis les pixels.
- **TD attendu** :
  1. écrire **à la main** dans l'éditeur une mini-image `P2` (ex. 4×4, un motif de valeurs 0/255) ; la voir agrandie : `magick motif.pgm -scale 800x apercu.png` ;
  2. la convertir en **binaire** (ImageMagick écrit du `P5` par défaut) : `magick motif.pgm binaire.pgm` ; l'ouvrir en **hexadécimal** (extension VSCode *Hex Editor*, ou `Format-Hex` sous PowerShell / `xxd` sous Linux-mac) ;
  3. **repérer** l'en-tête ASCII lisible (`P5\n4 4\n255\n`) puis les octets de pixels ; comparer la **taille** texte vs binaire ;
  4. faire un `git diff` sur les deux : le `.pgm` ASCII a un diff **lisible**, le binaire un diff **illisible** → justifie « pourquoi le texte se versionne bien » (lien c1 ↔ git).
- **Liens** : octets & hexadécimal (c1), texte vs binaire (c1), **pixels = tableau** (TD7), taille & compression (c5). PNG mentionné en aparté comme « vrai format, compressé ».

### Suite (à détailler)

- 🎓 12′ `pathlib` · 🎓 13′ `subprocess` · 🎓 15′ `argparse` · ⌨️ 40′ mini-pipeline ImageMagick + ffmpeg.
- Exemple déjà entre leurs mains : [`data/cours1/make_data.py`](../../../data/cours1/make_data.py) utilise `pathlib` et `subprocess` — le relire ensemble est un point d'entrée gratuit.
