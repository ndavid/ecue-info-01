// Illustrations des guides de TD, dessinées en typst : la fenêtre de VS Code
// avec son terminal Git Bash. Ce sont des schémas, pas des captures d'écran :
// les libellés sont ceux de VS Code en français, la disposition est
// simplifiée.
//
// Chaque guide qui en a besoin a un fichier `illustrations/<nom>.typ` qui
// appelle une de ces fonctions ; `outils/compiler_guides.py` le compile en PNG.
#import "theme.typ": accent, brun, estompe, gris, police-texte, police-code, demi-gras

#let _repere(n) = box(
  fill: brun, radius: 50%, inset: 3pt,
  text(size: 9pt, weight: "bold", fill: white)[#n],
)

// La fenêtre de VS Code : l'explorateur à gauche, le fichier au centre, le
// terminal en bas, et le menu ouvert par la flèche à côté du `+`.
// `dossier` : le dossier ouvert ; `invite` : ce qu'affiche le terminal.
#let vscode-git-bash(dossier, invite, fichiers: ()) = {
  set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
  let bord = 0.8pt + accent.lighten(55%)
  block(width: 17cm, stroke: bord, clip: true)[
    // La barre de menus
    #block(width: 100%, fill: gris, inset: (x: 8pt, y: 5pt))[
      Fichier #h(8pt) Édition #h(8pt) Sélection #h(8pt) Affichage #h(8pt) Exécuter #h(8pt) *Terminal* #h(8pt) Aide
      #h(1fr) #text(fill: estompe)[#dossier — Visual Studio Code]
    ]
    #grid(
      columns: (4.2cm, 1fr),
      // L'explorateur
      block(width: 100%, height: 7.6cm, fill: gris.lighten(40%), inset: 8pt, stroke: (right: bord))[
        #text(size: 8.5pt, weight: demi-gras, fill: estompe)[EXPLORATEUR]
        #v(4pt)
        #text(size: 9.5pt, weight: demi-gras)[#dossier]
        #for f in fichiers [
          #v(1pt)
          #h(8pt) #text(size: 9.5pt)[#f]
        ]
      ],
      grid(
        rows: (2.9cm, 4.7cm),
        // Le fichier ouvert
        block(width: 100%, height: 100%, inset: 8pt)[
          #text(size: 9pt, fill: estompe)[le fichier ouvert dans l'éditeur]
        ],
        // Le panneau du terminal
        block(width: 100%, height: 100%, stroke: (top: bord), inset: 0pt)[
          #block(width: 100%, inset: (x: 8pt, y: 4pt), stroke: (bottom: bord))[
            #text(size: 8.5pt, fill: estompe)[PROBLÈMES #h(8pt) SORTIE #h(8pt)] #text(size: 8.5pt, weight: demi-gras)[TERMINAL]
            #h(1fr)
            #text(size: 11pt)[+] #h(2pt) #box(stroke: 1.2pt + brun, inset: (x: 3pt, y: 1pt), radius: 2pt)[#text(size: 8pt)[▼]] #h(3pt) #_repere(1)
          ]
          #place(top + right, dx: -6pt, dy: 22pt, block(
            width: 4.6cm, fill: white, stroke: bord, inset: 6pt, radius: 3pt,
          )[
            #set text(size: 9.5pt)
            #set align(left)
            #block(width: 100%, fill: brun.lighten(80%), inset: 3pt)[*Git Bash* #h(1fr) #_repere(2)]
            #block(inset: 3pt)[Command Prompt]
            #block(inset: 3pt)[PowerShell]
          ])
          #block(inset: 8pt, width: 7.2cm)[
            #set align(left)
            #text(font: police-code, size: 8.5pt, raw(invite))
          ]
        ],
      ),
    )
  ]
  v(4pt)
  block(width: 17cm, text(size: 9.5pt, fill: estompe)[
    #_repere(1) la flèche à côté du `+`, en haut à droite du panneau du
    terminal ; #_repere(2) « Git Bash » dans le menu. Le terminal ouvert
    affiche une invite qui se termine par `$`.
  ])
}
