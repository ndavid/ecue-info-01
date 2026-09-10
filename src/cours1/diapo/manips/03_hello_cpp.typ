// Manipulation du cours 1 — « Le même programme en C++ ».
//
// Incluse par `cours1.typ`, qui porte les réglages globaux, et compilable
// seule par `outils/compiler_manips.py`, qui en tire la feuille d'instructions
// déposée dans le dossier de données de la manipulation. Un fichier inclus
// n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *


#separateur-manip(
  "Le même programme en C++",
  annonce: "Configurer l'éditeur pour un second langage : l'extension, le compilateur, puis la compilation",
  dossier: "data/cours1/hello/cpp/",
)
#d("Installer l'extension C/C++")[
  #annonce[
    Un autre langage demande une autre extension. Celle-ci apporte la
    coloration, la vérification et un bouton d'exécution pour C et C++.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [Le geste], [Ce qu'il donne],
    [`Ctrl` + `Maj` + `X`, chercher « C/C++ »],
      [l'extension publiée par Microsoft, à installer],
    [Rouvrir `cpp/bonjour.cpp`],
      [le code se colore, et les fautes d'écriture se soulignent],
  )

  #avertissement[
    L'extension n'apporte pas de compilateur. Elle sait lire le C++, pas le
    traduire : c'est l'objet de la diapositive suivante.
  ]

  #notes[
    C'est l'exemple qui généralise : un éditeur générique se configure langage
    par langage, et le geste est le même que pour Python.

    L'avertissement est écrit dans la documentation de VSCode : « The C/C++
    extension doesn't include a C++ compiler or debugger, since VS Code as an
    editor relies on command-line tools for the development workflow. »
    C'est la confusion la plus coûteuse de la séance.
  ]
]
#d("Installer un compilateur")[
  #annonce[
    Python vient avec l'environnement du module. Un compilateur C++, non :
    Windows n'en fournit aucun.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [Linux, macOS], [Windows],
    [Le compilateur],
      [`g++`, presque toujours déjà là],
      [aucun d'origine],
    [Comment l'obtenir],
      [rien à faire],
      [`conda install -c conda-forge gxx`],
    [Ce qu'on tape ensuite],
      [`g++ …`],
      [`x86_64-w64-mingw32-g++ …`],
  )

  #legende[
    L'environnement conda ne sert pas qu'à Python : il installe aussi des
    outils. On passe par lui parce qu'il est déjà là, et qu'il évite de
    toucher aux réglages de la machine.
  ]

  #notes[
    À faire avant la séance si possible : quelques minutes, et le réseau de la
    salle n'est pas garanti. À défaut, lancer l'installation au début de la
    manipulation et enchaîner sur autre chose pendant ce temps.

    Le chemin officiel n'est pas celui-là. La documentation de VSCode fait
    installer MinGW-w64 par MSYS2, puis ajouter `C:\msys64\ucrt64\bin` au
    `PATH` de Windows. Il fonctionne, mais il modifie la machine et demande une
    installation de plus ; le module préfère l'environnement conda, déjà
    présent et supprimable d'un seul geste. Le dire si la question vient, et
    surtout si un étudiant arrive avec MSYS2 déjà installé : dans ce cas la
    commande est `g++`, comme sous Linux.

    Le nom de l'exécutable est le piège, à projeter : sous Windows,
    conda-forge installe `x86_64-w64-mingw32-g++.exe`, pas `g++`. C'est le nom
    complet de la cible, et il ne s'invente pas. Relevé dans le contenu du
    paquet `gxx_win-64` ; non confirmé sur une machine Windows, à vérifier
    avant la séance.

    Ne pas employer `m2w64-toolchain`, encore présent dans de vieilles réponses
    en ligne : le paquet s'annonce lui-même obsolète.
  ]
]
#d("Compiler, puis lancer")[
  #annonce[
    Deux commandes au lieu d'une : la première produit un fichier, la seconde
    exécute ce fichier.
  ]

  #tableau(
    columns: (auto, 1fr),
    align: left + horizon,
    [], [Ce qu'il faut faire],
    [1], [Terminal #sym.arrow.r Nouveau terminal, dans `data/cours1/hello/`],
    [2], [taper `g++ cpp/bonjour.cpp -o cpp/bonjour`, puis Entrée],
    [3], [taper `cpp/bonjour`, puis Entrée],
    [4], [en option : mettre tout `bonjour.cpp` sur une seule ligne, recompiler],
  )

  #legende[
    L'étape 2 n'affiche rien, et c'est normal : elle produit un fichier. Sous
    Windows, la commande est `x86_64-w64-mingw32-g++`, le fichier produit
    s'appelle `cpp\bonjour.exe` et se lance par `.\cpp\bonjour.exe`.
  ]

  #notes[
    Étape 2 : rien ne s'affiche, la question vient. Faire regarder
    l'arborescence à gauche, où `cpp/bonjour` vient d'apparaître. C'est la
    différence avec Python, qui n'a rien laissé.

    Le bouton d'exécution existe aussi pour le C++, « Run C/C++ File » : il
    demande le compilateur au premier lancement et écrit un `tasks.json`. Ne
    pas l'employer en séance, mais savoir répondre.

    Étape 4, facultative : tout `bonjour.cpp` tient sur une ligne —
    `#include <iostream>` doit rester seul, c'est une directive — et le
    programme compile et affiche la même chose. Le compilateur ne voit pas les
    retours à la ligne, seulement les points-virgules et les accolades. Faire
    ensuite tenter la même chose sur un programme Python à boucle : cela
    échoue. C'est « Espaces, tabulations et fins de ligne » démontré.
  ]
]
#d("Ce que chaque lancement a produit")[
  #annonce[
    Les deux programmes affichent la même phrase. Ce qui les distingue est le
    nombre d'étapes, et ce qui reste sur le disque.
  ]

  #tableau(
    columns: (auto, 1fr, 1fr),
    align: left + horizon,
    [], [`python/bonjour.py`], [`cpp/bonjour.cpp`],
    [Nombre d'étapes], reponse[une], reponse[deux : compiler, puis exécuter],
    [Ce qui apparaît dans l'arborescence],
      reponse[rien],
      reponse[`cpp/bonjour`, un exécutable],
    [Taille du fichier source], [121 octets], [230 octets],
    [Taille du fichier produit],
      reponse[aucun fichier],
      reponse[environ 20 000 octets],
  )

  #legende[
    La taille de l'exécutable dépend du compilateur et du système ; le
    rapport à la source, près de cent fois, n'en dépend pas.
  ]

  #notes[
    C'est « Deux chemins du texte à l'exécution » fait à la main : y
    renvoyer.

    Le rapport de taille est le chiffre à faire dire. L'exécutable
    embarque de quoi tourner sans le compilateur, d'où le facteur cent ;
    le fichier Python ne peut rien sans l'interpréteur, déjà installé et
    qu'on ne compte donc pas.

    Faire ouvrir `cpp/bonjour` dans l'éditeur : illisible, c'est « Code
    source et fichier exécutable » vérifié par eux. Ajouter que `python`
    est un exécutable de la même espèce.

    Le terminal est repris à la partie « Environnement de programmation »,
    où le dossier courant est nommé.
  ]
]
// Le résultat de la manipulation, quand la capture est disponible.
#if captures-disponibles {
d("Les deux exécutions dans l'éditeur")[
  #annonce[
    Le terminal de l'éditeur garde la trace des trois commandes, et
    l'arborescence montre le fichier que la compilation vient de produire.
  ]

  #align(center)[
    #illustration(
      "/illustrations/cours1/vscode_hello.png",
      none,
      hauteur: hauteur-capture-pleine,
    )
  ]

  #legende[
    `cpp/bonjour` n'existait pas avant la deuxième commande. Le programme
    Python, lui, n'a rien laissé.
  ]

  #notes[
    Trois commandes, deux langages, une seule fenêtre : l'argument de
    l'éditeur de code, montré plutôt qu'énoncé.

    La sortie est identique, le chemin pour l'obtenir non.
  ]
]
}
