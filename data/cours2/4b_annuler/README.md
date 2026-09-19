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

Le commit créé par `git revert` **n'a pas** le même identifiant que celui
qu'il annule : il rend le même contenu, mais c'est un commit de plus, ajouté
au bout de l'historique. Rien n'est effacé — c'est ce qui rend `revert` sans
danger sur un historique déjà partagé.

Le `rebase`, lui, réécrit : les commits de la branche changent d'identifiant.
Afficher `git llog` avant et après, c'est le seul moyen de le voir. C'est sans
conséquence ici parce que personne d'autre n'a récupéré cette branche ; en
équipe, ce serait à éviter, et le cours 6 y revient.
