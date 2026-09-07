"""Les premiers octets d'un fichier, et ce qu'ils disent de son format.

Le système choisit un logiciel d'après l'extension du nom. Le logiciel, lui,
ouvre le fichier et lit ses premiers octets. Ce script fait la même chose : il
lit quatre octets et les compare à un catalogue de signatures.

    python octets.py                        # les fichiers de l'exercice
    python octets.py ../genere/raven.odt    # un fichier de son choix
"""

import sys
from pathlib import Path

GENERE = Path(__file__).resolve().parent.parent / "genere"

# Ces octets de tête s'appellent des nombres magiques. Un fichier texte n'en a
# pas : c'est précisément ce qui rend deux fichiers texte indiscernables.
SIGNATURES = {
    b"PK\x03\x04": "archive ZIP, donc .odt, .docx, .xlsx ou .epub",
    b"%PDF": "document PDF",
    b"\x89PNG": "image PNG",
    b"\xff\xd8\xff\xe0": "image JPEG",
}

FICHIERS = [
    GENERE / "raven_une_ligne.txt",
    GENERE / "raven_une_ligne.donnees",
    GENERE / "raven.odt",
    GENERE / "raven_brut.html",
    GENERE / "raven.pdf",
]


def entete(chemin, taille=4):
    """Les premiers octets du fichier, sans lire le reste."""
    with open(chemin, "rb") as fichier:
        return fichier.read(taille)


def en_hexadecimal(octets):
    """`50 4B 03 04` : chaque octet en deux chiffres hexadécimaux."""
    return " ".join(f"{octet:02X}" for octet in octets)


def en_caracteres(octets):
    """Les octets qui correspondent à un caractère affichable, les autres en point."""
    return "".join(chr(o) if 32 <= o < 127 else "." for o in octets)


def format_reconnu(octets):
    for signature, nom in SIGNATURES.items():
        if octets.startswith(signature):
            return nom
    return "aucune signature connue"


def main(arguments):
    chemins = [Path(a) for a in arguments] if arguments else FICHIERS
    for chemin in chemins:
        if not chemin.exists():
            print(f"{chemin.name:28} introuvable")
            continue
        octets = entete(chemin)
        print(f"{chemin.name:28} {en_hexadecimal(octets):12} {en_caracteres(octets):6} {format_reconnu(octets)}")


if __name__ == "__main__":
    main(sys.argv[1:])
