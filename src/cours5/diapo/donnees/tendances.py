#!/usr/bin/env python3
"""Écrit `tendances.typ` : cinquante ans de microprocesseurs, d'après Karl Rupp.

    python src/cours5/diapo/donnees/tendances.py

Les séries viennent du dépôt `karlrupp/microprocessor-trend-data` (CC BY 4.0),
qui prolonge les données de Horowitz, Labonte, Shacham, Olukotun, Hammond et
Batten. Quatre sont gardées, pour la diapositive « Trente ans de
processeurs » : transistors (milliers), fréquence (MHz), puissance (W) et
nombre de cœurs. Le fichier produit est versionné : quelques Ko, et la
diapositive compile sans réseau.
"""

from __future__ import annotations

import sys
import urllib.request
from pathlib import Path

ICI = Path(__file__).resolve().parent
BASE = "https://raw.githubusercontent.com/karlrupp/microprocessor-trend-data/master/50yrs/"
SERIES = {
    "transistors": "transistors.dat",   # milliers
    "frequence": "frequency.dat",       # MHz
    "puissance": "watts.dat",           # W
    "coeurs": "cores.dat",
}
DEPUIS = 1990


def lire(nom: str) -> list[tuple[float, float]]:
    requete = urllib.request.Request(BASE + nom, headers={"User-Agent": "info01-cours5/1.0"})
    with urllib.request.urlopen(requete, timeout=30) as reponse:
        texte = reponse.read().decode()
    points = []
    for ligne in texte.splitlines():
        if not ligne.strip() or ligne.startswith("#"):
            continue
        annee, valeur = ligne.split()
        if float(annee) >= DEPUIS:
            points.append((round(float(annee), 2), float(valeur)))
    return points


def main() -> int:
    lignes = [
        "// Généré par tendances.py, ne pas éditer à la main.",
        "// Source : Karl Rupp, microprocessor-trend-data (CC BY 4.0), séries 50yrs/.",
        f"// Points depuis {DEPUIS} ; (année, valeur).",
    ]
    for nom, fichier in SERIES.items():
        points = lire(fichier)
        corps = ", ".join(f"({a}, {v:g})" for a, v in points)
        lignes.append(f"#let {nom} = ({corps},)")
        print(f"{nom:12} {len(points)} points, {points[0][0]} à {points[-1][0]}")
    (ICI / "tendances.typ").write_text("\n".join(lignes) + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    sys.exit(main())
