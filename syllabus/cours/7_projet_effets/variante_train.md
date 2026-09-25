# Projet 7, variante train — Deux effets pour la fenêtre du train (document de conception)

> 25/09/2026. Pour les élèves qui ont fait le TD 4c ([conception](../4_projet_animation/td_4c_train.md)). Même objectif et même forme que le projet 7 ([contenu détaillé](contenu_detaille.md)) : une option `--effet`, chaque effet écrit en boucle puis avec numpy, un test d'égalité, un chronométrage, une pull request relue.

## Les deux effets

Ils reproduisent deux éléments du clip absents du TD 4c.

| Effet | Ce qu'on voit | Calcul pour le pixel (y, x) de l'image `numero` | Version numpy | Temps |
|---|---|---|---|---|
| `poteaux` | des ombres verticales qui traversent la vitre en quelques images | dans une bande si `(x - 90 × numero) % 400 < 24` ; chaque valeur `v` y devient `v × 6 // 10` | `np.arange(largeur)`, la même condition → colonnes booléennes ; `image[:, colonnes]` ; `astype(np.uint16)` avant `× 6` | boucle 0,04 s par image ; numpy 0,5 ms |
| `parallaxe` | la plage orange au premier plan, deux fois plus rapide que les voiles | `d = 16 × numero`, `xp = (x - d) % 1920` ; si `vitre[y, x]` et `plage[y, xp, 3] > 0`, le pixel prend `plage[y, xp, :3]` | `np.roll(plage, d, axis=1)[:, :640]` ; masque `vitre & (alpha > 0)` ; `resultat[masque] = …` | boucle 0,08 s ; numpy 4 ms |

Temps mesurés le 25/09 sur la machine de préparation (Ryzen 5 1600X, numpy 2.5.2), sur 120 images : poteaux 4,5 s contre 0,04 s ; parallaxe 9,7 s contre 0,31 s.

Deux points d'enseignement propres à ces effets :

- **le dépassement des `uint8`** (`poteaux`) : `image * 6` en `uint8` donne un résultat faux sans erreur ; le test `np.array_equal` le révèle. Le notebook le montre sur trois valeurs (section 3).
- **l'ordre des effets** (`parallaxe` puis `poteaux`, ou l'inverse) : `--effet` répété, `action="append"` ; la plage passe sous ou sur les ombres.

`poteaux` ne dépend pas du décor : il s'applique aussi à la montre et au tourbillon, et peut devenir un cinquième effet commun du TD 7a. `parallaxe` demande `decor/plage.png` et la vitre de `decor/fenetre.png`, lues une fois par `charger(decor)` dans un dictionnaire `DONNEES` (pas de `global`).

La fenêtre est dessinée sans lissage (`+antialias`) : chaque pixel est opaque ou transparent, et la vitre est un masque booléen exact. La plage aussi : son opacité vaut 0 ou 255.

## Déroulé (≈ 120′)

| Durée | Étape | Contenu |
|---|---|---|
| 🎓 10′ | Présentation | une image est un tableau ; les deux effets ; boucle et opération sur le tableau entier |
| ⌨️ 10′ | C0 | clone, branche `effet`, `conda install numpy pillow`, `environment.yml` |
| ⌨️ 10′ | C1 | le notebook `tableaux.ipynb` (outils, sur d'autres exemples : négatif, `x % 5 < 2`, masque de la moitié haute) |
| ⌨️ 5′ | C2 | `lire`, `ecrire`, `appliquer` (fournies) |
| ⌨️ 30′ | C3, C4 | `poteaux_boucle`, `poteaux_numpy`, `test_effet.py` |
| ⌨️ 10′ | C5 | `EFFETS`, l'option `--effet` |
| ⌨️ 10′ | C6 | `mesurer.py` (fourni), `RAPPORT.md`, images avant / après |
| ⌨️ 20′ | C7 | pull request, revue, fusion |
| second temps | C8 | `parallaxe`, `--effet` répétable, seconde pull request |

## Fichiers

| Fichier | Rôle |
|---|---|
| `effets_reference.py` (ce dossier) | `poteaux_boucle/numpy`, `parallaxe_boucle/numpy` ajoutés aux quatre effets ; égalité vérifiée pour les numéros 1, 3 et 50 |
| `data/cours7/make_data.py` | `build` : `7b_train/produit/depart/exemple.png` (image de la série du 4c) et `decor/` (plage, fenêtre) pour le notebook |
| `data/cours7/7b_train/depart/modeles/` | `test_effet.py` (poteaux ; parallaxe en commentaire), `mesurer.py`, `RAPPORT.md` |
| `data/cours7/corriges/7b_train/` | `train.py` (4c + les deux effets + `--effet` répétable), `test_effet.py`, `mesurer.py` ; testés |
| `src/cours7/notebook/td/7b_train/` | le notebook `depart/notebook/tableaux.md` et le guide `guide.md` (écrit à la main, pas produit par un script) |

Le guide suit la règle du projet 7 : code fourni pour la plomberie, le test et le chronométrage ; pour les effets, le calcul par pixel et les outils numpy.

## Reste à faire

1. Le corrigé `train.py` du TD 7 est une copie du corrigé B3 du 4c, complétée : à refaire si `generer_corriges.py` change le programme.
2. Le dépôt de référence du 4c pour le cours 6 (programme de `b3/`, README de `b4/`, dossier `decor/`).
3. Le guide du TD 7a (quatre effets communs) n'existe pas encore ; les deux guides devraient partager C0, C2, C6 et C7.
4. Vérifier en salle les temps de la boucle et l'installation de numpy et Pillow dans `animation`.
