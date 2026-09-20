# Annuler et remettre à jour — TD 4b, cours 2

Questions 18 à 20 du TP. On simule une fausse manœuvre, on la défait, puis on
remet une branche à jour.

Ce TD n'a pas de fichier de départ : on travaille dans le projet créé au
TD 3a, `../3a_premier_depot/travail/projet_2`.

## Déroulé

```bash
# 18. la fausse manœuvre : on vide les deux fichiers, et on l'enregistre
git add src/
git commit -m "suppression accidentelle du code"

# 19. repérer le commit fautif, puis l'annuler
git log --oneline
git revert <identifiant du commit>

# 20. remettre main_code au niveau de develop
git checkout main_code
git rebase develop
```

## Ce qu'il faut avoir constaté

Le commit créé par `git revert` a son propre identifiant. Il est ajouté au
bout de l'historique, et le contenu du projet redevient celui d'avant la
suppression. Aucun commit n'est effacé.

Le `rebase` réécrit l'historique de la branche : ses commits changent
d'identifiant. Afficher `git llog` avant et après pour le constater. Une
branche que quelqu'un d'autre a déjà récupérée ne se rebase pas ; le cours 6
y revient.
