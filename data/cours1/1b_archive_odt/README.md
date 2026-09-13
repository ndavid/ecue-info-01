# Un `.odt` est une archive ZIP — TD 1b, cours 1, facultatif

Le même `raven.odt` que le TD 1a, dans son propre dossier : `depart/raven.odt`,
et `travail/` pour ce que vous fabriquez. Rien ici n'est versionné,
`make_data.py` y dépose la copie.

Le TD demande un gestionnaire d'archives, un éditeur de texte, et LibreOffice
pour rouvrir le résultat :

1. **Copier** `depart/raven.odt` dans `travail/` sous le nom `raven.zip` et
   l'extraire : six fichiers, dont `content.xml` (le texte) et `styles.xml`
   (la mise en forme).
2. **Modifier** `content.xml` et `styles.xml` dans un éditeur de texte.
3. **Recompresser** en `raven2.zip`, renommer en `raven2.odt`, rouvrir dans
   LibreOffice : le document a changé sans traitement de texte.

> Le piège à connaître : pour recompresser, sélectionner **les six fichiers**
> depuis l'intérieur du dossier `raven/`, et non le dossier lui-même. Sinon les
> chemins dans l'archive deviennent `raven/content.xml` et LibreOffice refuse
> d'ouvrir le fichier.
