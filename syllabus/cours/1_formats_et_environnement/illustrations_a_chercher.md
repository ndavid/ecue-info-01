# Illustrations à chercher ou à dessiner — Cours 1

Note de travail. Le deck du cours 1 s'appuie beaucoup sur des tableaux. Hors
annexes, ses 78 diapositives de contenu portent 48 tableaux, 16 comparaisons en
deux colonnes, et 11 schémas dessinés seulement. Le tableau est une preuve
visuelle légitime quand la comparaison est le propos
([`STYLE.md`](../../../STYLE.md)) ; il l'est moins quand il sert à énumérer, et
c'est ce déséquilibre que ce document relève.

Ce document relève, hors annexes, les diapositives qui gagneraient une
illustration, et dit laquelle. Il ne modifie rien : c'est une liste de travail.

---

## 1. Le cas particulier de la compilation et de l'interprétation

*Question posée : existe-t-il sur le web un schéma de qualité, non généré, sur
ce sujet, qu'on puisse reprendre avec sa source ou reproduire ?*

**Réponse : rien qui vaille mieux que ce que le deck peut dessiner.** La
recherche a été faite, et voici ce qu'elle donne.

### Ce qui existe, et pourquoi c'est écarté

| Source | Licence | Verdict |
|---|---|---|
| [`Compiler scheme (en).svg`](https://commons.wikimedia.org/wiki/File:Compiler_scheme_(en).svg) — Wikimedia Commons, Seda Kh. / Nyq, 2015-2024 | CC BY-SA 4.0 | Fait main, correct, employé sur Wikipédia. Mais il descend jusqu'à l'AST, au générateur de code et à l'assembleur : c'est le niveau d'un cours de compilation, pas celui d'une séance 1. |
| [`Code interpreter scheme.png`](https://commons.wikimedia.org/wiki/File:Code_interpreter_scheme.png) — Wikimedia Commons, Seda Kh., 2015 | CC BY-SA 4.0 | Le pendant du précédent, avec *bytecode* et *virtual machine*. Même problème, et en plus il n'est pas vectoriel. |
| Sites de cours NSI français ([glassus](https://glassus.github.io/), maths-code, la forge des communs numériques éducatifs) | CC BY-SA | Schémas plus simples, mais de qualité inégale, et même contrainte de licence. |

Trois raisons de ne pas les reprendre :

1. **Le niveau ne correspond pas.** Les deux diagrammes de Commons introduisent
   quatre notions que la séance écarte explicitement — arbre syntaxique,
   génération de code, bytecode, machine virtuelle. Les projeter ouvrirait des
   questions auxquelles la séance ne répond pas.
2. **Les couleurs sont décoratives.** Orange, vert et rouge y codent des
   niveaux d'emboîtement, sans rapport avec la règle du deck, où le bleu est le
   cours et le brun la machine.
3. **CC BY-SA est contaminant.** Redessiner l'un de ces schémas en produit une
   adaptation, qui doit alors être publiée sous la même licence. Le deck est en
   CC-BY : reprendre l'idée générale ne pose pas de problème, reproduire la
   composition si.

Aucun équivalent en CC0 ou CC-BY n'a été trouvé.

### Ce qu'il faut faire à la place

La diapositive **« Deux chemins du texte à l'exécution »** a déjà la bonne
ossature : deux chaînes superposées, l'une avec une étape de plus. Ce qui lui
manque n'est pas un dessin plus joli, c'est la **conséquence**, qui est
aujourd'hui dans les notes seulement :

> après la compilation, le compilateur n'est plus nécessaire ; l'interpréteur,
> lui, doit être présent à chaque exécution.

C'est exactement ce qu'un schéma sait montrer et qu'une chaîne linéaire ne
montre pas. Proposition, à dessiner en typst, sans source externe :

```
Compilé      bonjour.cpp ──[compilateur]──> bonjour.exe ──> résultat
                             une seule fois                 ──> résultat
                                                            ──> résultat

Interprété   bonjour.py ──[python]──> résultat
             bonjour.py ──[python]──> résultat      python à chaque fois
             bonjour.py ──[python]──> résultat
```

Trois exécutions figurées de chaque côté, et la boîte de l'outil présente une
fois à gauche, trois fois à droite. Cela répond du même coup à la question qui
ouvre la partie 4 — pourquoi faut-il que Python soit installé — et le mot
« interpréteur » y prend son sens courant, celui de la cabine de traduction.

---

## 2. Les diapositives qui gagneraient une illustration

Classées par intérêt. « Dessiner » signifie en typst, avec les gabarits
existants ; aucune ne demande d'image externe.

### Fortement recommandées

| Diapositive | Partie | Aujourd'hui | Ce que l'illustration montrerait |
|---|---|---|---|
| **Contenu de l'archive `.odt`** | 1 | tableau de cinq fichiers | L'archive dessinée comme un conteneur, avec les six fichiers dedans et `content.xml` mis en avant. C'est l'image centrale de la séance — « un document est une boîte » — et elle n'existe nulle part dans le deck. |
| **Ce qu'une bibliothèque contient vraiment** | 4 | tableau 4 × 3 | Deux paquets dessinés côte à côte : l'un ne contenant que du texte, l'autre du texte **plus** un binaire par système. La notion la plus difficile de la partie est aujourd'hui portée par la ligne 3 d'un tableau. |
| **Trois façons d'ouvrir un notebook** | 5 | tableau + sortie console | Trois vignettes montrant *où tourne le noyau* : sur la machine, sur la machine, dans l'onglet. C'est le propos exact de la diapositive, et il est invisible dans un tableau. |
| **Les fichiers texte d'un projet** | 3 | tableau `.py` / `.csv` / `.md` / `.json` | Une arborescence de projet dessinée, avec les types annotés. Le deck parle d'arborescence depuis la partie 2 sans jamais en montrer une. |
| **Espaces, tabulations et fins de ligne** | 3 | sortie console + tableau | Deux lignes de code superposées avec les caractères invisibles rendus (`·` et `→`), montrant qu'elles sont alignées à l'écran et différentes dans le fichier. La capture d'écran fait ce travail, mais seulement si les captures sont disponibles. |
| **Le terminal de l'éditeur de code**, **Les fonctions d'un IDE**, **Exécuter pas à pas dans l'éditeur** | 2 et 4 | trois tableaux | Une même fenêtre d'éditeur dessinée, annotée différemment sur chacune. Le gabarit `fenetre()` existe déjà. Trois tableaux deviennent trois vues d'un même objet, et la salle reconnaît la fenêtre qu'elle a sous les yeux. |

### Utiles

| Diapositive | Partie | Ce que l'illustration montrerait |
|---|---|---|
| **Contenu de la séance** | 0 | Une bande horizontale où la largeur de chaque partie est sa durée : la forme de la séance se lit d'un coup, et les manipulations s'y voient. |
| **Organisation : sept séances** | 0 | La même bande, sur le semestre, avec les deux TD marqués. Le gabarit `frise()` ajouté pour la partie 4 s'y prête. |
| **Où s'exécute une application web ?** | 1 | Le fichier qui reste sur la machine, ou qui part vers un serveur. Deux dessins de trois boîtes suffisent. |
| **Ce que chaque lancement a produit** | 2 | 121 octets contre 20 000 : deux barres proportionnelles rendent le facteur cent visible, là où deux nombres dans un tableau ne le rendent pas. |
| **Deux formats de notebook** | 5 | Les deux `diff` côte à côte, 2 lignes contre 23. Montrer les diffs plutôt que leurs longueurs. |
| **Une bibliothèque en entraîne d'autres** | 4 | 15 pastilles contre 352 : la chaîne actuelle dit les chiffres, elle ne les fait pas voir. |
| **Un même document, trois formats** | 1 | Ce que chaque conversion enlève, en trois étapes fléchées. L'idée est aujourd'hui dans les notes seulement. |

### À laisser tel quel

Les tableaux de **comparaison** restent la bonne forme quand la comparaison
*est* le propos, et ils ne sont pas à remplacer :
« Les règles d'écriture d'un langage », « Extension de fichier et extension de
VSCode », « Trois façons d'écrire un document », « Quand un notebook, quand un
script ». Les diapositives de manipulation gardent aussi leur tableau : la
colonne masquée par `reponse[…]` est un dispositif, pas un pis-aller.

---

## 3. Une question de fond, à trancher une fois

Le deck colore la syntaxe de ses blocs de code — rouge pour les mots-clés, vert
pour les chaînes, bleu pour les appels. C'est le comportement par défaut de
typst, et il est en tension avec la règle du thème, qui n'admet que trois
couleurs et leur donne un sens unique.

Deux positions défendables, et il faut en choisir une :

- **La garder.** La coloration est ce que fait l'éditeur de code, la séance
  l'enseigne à la partie 3, et la retirer des diapositives serait montrer autre
  chose que ce que les étudiants ont à l'écran.
- **La supprimer partout sauf sur la diapositive « Coloration syntaxique »**,
  où elle est le sujet. Le contraste y serait alors maximal, et la règle des
  trois couleurs tiendrait sans exception ailleurs.

L'état actuel n'est ni l'un ni l'autre : c'est le défaut de l'outil, subi.
