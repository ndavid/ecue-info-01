# Contenu détaillé — Cours 1 : Formats de fichier & environnement de développement

Vue d'ensemble : [../../01_syllabus_v1.md](../../01_syllabus_v1.md) (section « Cours 1 »).

Objectif : comprendre les formats de fichier et savoir les utiliser dans un but informatique (programmation et documentation).

## Déroulé détaillé

* **🎓 Formats de fichiers / extension** :
  - format selon type : rapport `docx`/`pdf`, archive `zip`, image `png`/`raw`, vidéo, `.txt`/`.html`.
  - Application : afficher l'extension, renommer et tester l'ouverture ; ouvrir un `.odt` (extraction texte) ; ouvrir un `.html` local dans le navigateur.

* **🎓 Programmation & format associé** : langage / interpréteur / IDE ; texte (instructions, conventions) → sortie binaire ou action.
  - installer VSCode ; extensions (js/py/md/css/html) ; édition, explorateur (n° de ligne, tabulation/espace) ; interpréteur Python (un calcul, lancer un script).

* **🎓 Format binaire et texte** : encodage bit, puissances de 2, hexadécimal (code couleur) ; ASCII et Unicode → `.txt` ; nom des symboles de programmation.
  - petit script Python : liste de codes ASCII → fichier texte, et inverse ; écrire un symbole Unicode / emoji dans l'éditeur.

* **🎓 Formats texte** : `docx`, LaTeX, `txt`, `md` — intérêt du Markdown pour README / doc.

* **⌨️ Ligne de commande — appel d'un programme simple** : génération / transformation de doc (ex. fiche ou recette en Markdown → HTML), visualisation de la sortie dans VSCode.

* **Notebook** (optionnel) : différence `.ipynb` vs MyST ; où est l'interpréteur (serveur JupyterLab) ; exemple de doc en MyST.

## Focus — Visualiser une image binaire en hexadécimal (PGM/PPM)

Objectif : rendre tangible « un fichier binaire = une suite d'octets » en **regardant** une image minuscule, et faire le lien texte ↔ binaire ↔ pixels (prépare le TD7).

**Pourquoi PGM/PPM (Netpbm) et pas PNG.** PNG est réaliste mais **compressé** (chunks + zlib) → illisible pour un débutant. Le format **Netpbm** est le plus simple qui existe : en-tête en clair, puis les pixels bruts. Il a une variante **ASCII** et une variante **binaire** du *même* contenu — idéal pour la leçon texte vs binaire.

- **Structure** : un « magic number » (`P2` = gris ASCII, `P5` = gris binaire ; `P3`/`P6` = couleur RGB), puis `largeur hauteur`, la valeur max (255), puis les pixels.
- **Manipulation attendue** :
  1. écrire **à la main** dans l'éditeur une mini-image `P2` (ex. 4×4, un motif de valeurs 0/255) ; la voir agrandie : `magick motif.pgm -scale 800x apercu.png` ;
  2. la convertir en **binaire** (ImageMagick écrit du `P5` par défaut) : `magick motif.pgm binaire.pgm` ; l'ouvrir en **hexadécimal** (extension VSCode *Hex Editor*, ou `Format-Hex` sous PowerShell / `xxd` sous Linux-mac) ;
  3. **repérer** l'en-tête ASCII lisible (`P5\n4 4\n255\n`) puis les octets de pixels ; comparer la **taille** texte vs binaire ;
  4. faire un `git diff` sur les deux : le `.pgm` ASCII a un diff **lisible**, le binaire un diff **illisible** → justifie « pourquoi le texte se versionne bien » (lien c1 ↔ git).
- **Liens** : octets & hexadécimal (c1), texte vs binaire (c1), **pixels = tableau** (TD7), taille & compression (c5). PNG mentionné en aparté comme « vrai format, compressé ».
