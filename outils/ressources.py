#!/usr/bin/env python3
"""Transporte les ressources qui ne sont pas dans le dépôt, sans copier à la main.

Deux sortes de fichiers ne sont pas versionnés, et pour deux raisons opposées :

    produit/   ce qu'une commande refabrique — `make_data.py`, `carte.py`, une
               compilation. Le perdre ne coûte qu'un temps de calcul.
    fourni/    ce qui vient d'ailleurs et ne se refabrique pas : textes
               téléchargés, tuiles OpenStreetMap dont les conditions d'usage
               interdisent le téléchargement en masse.

Les images des supports, dans `illustrations/`, sont du second genre : les
recréer demanderait de refaire les captures d'écran une à une.

Seul ce second genre doit voyager d'un poste à l'autre. Ce script s'en charge,
et vérifie ce qu'il a fait plutôt que de faire confiance à un copier-coller :

    python outils/ressources.py exporter /media/…/info01-ressources
    python outils/ressources.py exporter /media/…/info01-ressources --archive
    python outils/ressources.py importer /media/…/info01-ressources
    python outils/ressources.py verifier

`exporter` écrit aussi `outils/ressources.json`, qui retient la taille et
l'empreinte de chaque fichier. Ce fichier est versionné : `verifier` dit donc,
sur un poste où rien n'a encore été copié, ce qui manque et ce qui a changé —
sans avoir la source sous la main.

Aucune commande n'efface quoi que ce soit, et `importer` refuse d'écraser un
fichier dont le contenu diffère tant qu'on ne le lui demande pas.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import shutil
import subprocess
import sys
import zipfile
from datetime import date
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
MANIFESTE = RACINE / "outils" / "ressources.json"

# Les motifs disent où sont les ressources à transporter. Les ajouter ici, et
# nulle part ailleurs : une séance nouvelle est couverte sans rien écrire. Les
# deux dossiers réservés vivent dans le dossier d'un TD, `data/cours<n>/<td>/`.
MOTIFS_FOURNI = ("data/*/*/fourni", "illustrations/*")
MOTIFS_PRODUIT = ("data/*/*/produit",)


def dossiers(avec_produit: bool) -> list[Path]:
    motifs = MOTIFS_FOURNI + (MOTIFS_PRODUIT if avec_produit else ())
    trouves = []
    for motif in motifs:
        trouves += [d for d in RACINE.glob(motif) if d.is_dir()]
    return sorted(set(trouves))


def suivis_par_git() -> set[str]:
    """Ce que git transporte déjà, et que ce script n'a donc pas à doubler."""
    try:
        sortie = subprocess.run(["git", "-C", str(RACINE), "ls-files"],
                                capture_output=True, text=True, check=True).stdout
    except (OSError, subprocess.CalledProcessError):
        return set()
    return set(sortie.split("\n"))


def fichiers(avec_produit: bool) -> list[Path]:
    """Les chemins relatifs à la racine du dépôt, triés."""
    versionnes = suivis_par_git()
    liste = []
    for d in dossiers(avec_produit):
        liste += [f.relative_to(RACINE) for f in d.rglob("*")
                  if f.is_file() and "__pycache__" not in f.parts
                  and str(f.relative_to(RACINE)) not in versionnes]
    return sorted(set(liste))


def empreinte(chemin: Path) -> str:
    h = hashlib.sha256()
    with open(chemin, "rb") as f:
        for bloc in iter(lambda: f.read(1 << 20), b""):
            h.update(bloc)
    return h.hexdigest()


def decrire(relatifs: list[Path]) -> dict:
    return {
        str(r): {"taille": (RACINE / r).stat().st_size,
                 "sha256": empreinte(RACINE / r)}
        for r in relatifs
    }


def lire_manifeste() -> dict:
    if not MANIFESTE.exists():
        return {}
    return json.loads(MANIFESTE.read_text(encoding="utf-8")).get("fichiers", {})


def copier(source: Path, cible: Path) -> None:
    cible.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, cible)
    # La copie est relue : c'est le seul moyen de savoir qu'une clé pleine ou
    # démontée en cours de route n'a pas laissé un fichier tronqué.
    if empreinte(cible) != empreinte(source):
        raise SystemExit(f"copie incorrecte : {cible}")


def exporter(args) -> int:
    dest = Path(args.dossier).expanduser().resolve()
    relatifs = fichiers(args.avec_produit)
    if not relatifs:
        print("aucune ressource à exporter", file=sys.stderr)
        return 1

    inchanges = copies = 0
    for r in relatifs:
        source, cible = RACINE / r, dest / r
        if cible.exists() and empreinte(cible) == empreinte(source):
            inchanges += 1
            continue
        if args.simuler:
            print(f"  copierait  {r}")
        else:
            copier(source, cible)
        copies += 1

    description = decrire(relatifs)
    if not args.simuler:
        MANIFESTE.write_text(
            json.dumps({"genere_le": date.today().isoformat(),
                        "avec_produit": args.avec_produit,
                        "fichiers": description}, indent=2, ensure_ascii=False) + "\n",
            encoding="utf-8")
        (dest / "LISEZMOI.txt").write_text(
            "Ressources du module info01 qui ne sont pas dans le dépôt.\n\n"
            "Pour les remettre en place sur un autre poste, depuis la racine\n"
            "du dépôt cloné :\n\n"
            f"    python outils/ressources.py importer {dest}\n\n"
            "La commande vérifie chaque fichier et n'écrase rien sans le dire.\n",
            encoding="utf-8")

    octets = sum(d["taille"] for d in description.values())
    verbe = "à copier" if args.simuler else "copiés"
    print(f"{len(relatifs)} fichier(s), {octets / 1e6:.1f} Mo — "
          f"{copies} {verbe}, {inchanges} déjà à jour")
    print(f"destination : {dest}")

    if args.archive and not args.simuler:
        archive = dest.parent / f"info01-ressources-{date.today().isoformat()}.zip"
        with zipfile.ZipFile(archive, "w", zipfile.ZIP_DEFLATED) as z:
            for r in relatifs:
                z.write(RACINE / r, str(r))
        print(f"archive : {archive} ({archive.stat().st_size / 1e6:.1f} Mo)")
    return 0


def importer(args) -> int:
    source = Path(args.dossier).expanduser().resolve()
    if not source.is_dir():
        print(f"{source} : introuvable", file=sys.stderr)
        return 1

    attendus = lire_manifeste()
    if not attendus:
        # Sans manifeste, on prend ce que la source contient : c'est le cas
        # d'un poste neuf dont le dépôt est plus ancien que les ressources.
        attendus = {str(f.relative_to(source)): None
                    for f in source.rglob("*")
                    if f.is_file() and f.name != "LISEZMOI.txt"}

    nouveaux, identiques, differents, absents = [], [], [], []
    for rel in sorted(attendus):
        venant, allant = source / rel, RACINE / rel
        if not venant.exists():
            absents.append(rel)
            continue
        if allant.exists():
            (identiques if empreinte(allant) == empreinte(venant)
             else differents).append(rel)
        else:
            nouveaux.append(rel)

    for rel in nouveaux:
        if not args.simuler:
            copier(source / rel, RACINE / rel)
    for rel in differents:
        if args.forcer and not args.simuler:
            copier(source / rel, RACINE / rel)

    verbe = "à installer" if args.simuler else "installés"
    print(f"{len(nouveaux)} fichier(s) {verbe}, {len(identiques)} déjà identiques")
    if differents:
        etat = ("remplacés" if args.forcer and not args.simuler
                else "laissés en place — relancer avec --forcer pour les remplacer")
        print(f"{len(differents)} fichier(s) de contenu différent, {etat} :")
        for rel in differents[:10]:
            print(f"    {rel}")
    if absents:
        print(f"{len(absents)} fichier(s) attendus par le manifeste et absents "
              f"de la source :")
        for rel in absents[:10]:
            print(f"    {rel}")
    return 1 if absents else 0


def verifier(args) -> int:
    attendus = lire_manifeste()
    if not attendus:
        print(f"{MANIFESTE.relative_to(RACINE)} : absent — lancer « exporter » "
              f"une fois pour le produire", file=sys.stderr)
        return 1

    manquants, alteres = [], []
    for rel, ref in sorted(attendus.items()):
        f = RACINE / rel
        if not f.exists():
            manquants.append(rel)
        elif f.stat().st_size != ref["taille"] or empreinte(f) != ref["sha256"]:
            alteres.append(rel)

    presents = len(attendus) - len(manquants) - len(alteres)
    print(f"{len(attendus)} ressource(s) attendues : {presents} conformes, "
          f"{len(manquants)} manquantes, {len(alteres)} modifiées")
    for titre, liste in (("manquantes", manquants), ("modifiées", alteres)):
        for rel in liste[:10]:
            print(f"    {titre[:9]:9} {rel}")
    if manquants:
        print("\nLes remettre en place :  python outils/ressources.py importer <dossier>")
    return 1 if manquants or alteres else 0


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    sous = p.add_subparsers(dest="action", required=True)

    e = sous.add_parser("exporter", help="copier les ressources vers un dossier externe")
    e.add_argument("dossier")
    e.add_argument("--archive", action="store_true",
                   help="produire aussi un zip à côté du dossier")
    e.add_argument("--avec-produit", action="store_true",
                   help="inclure aussi les dossiers produit/, refabricables")
    e.add_argument("--simuler", action="store_true", help="ne rien écrire")
    e.set_defaults(fonction=exporter)

    i = sous.add_parser("importer", help="remettre les ressources dans le dépôt")
    i.add_argument("dossier")
    i.add_argument("--forcer", action="store_true",
                   help="remplacer les fichiers dont le contenu diffère")
    i.add_argument("--simuler", action="store_true", help="ne rien écrire")
    i.set_defaults(fonction=importer)

    v = sous.add_parser("verifier", help="comparer le dépôt au manifeste versionné")
    v.set_defaults(fonction=verifier)

    args = p.parse_args()
    return args.fonction(args)


if __name__ == "__main__":
    sys.exit(main())
