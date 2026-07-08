# Annexe H — Ressources & rendu du CV (Markdown / Typst)

*Pointeurs **vérifiés** (2026-07-08) pour EX3 (CV) et AV2 (Typst). Tri critique : les listicles « top X » et collections sans fond ont été écartés. Filtre décisif : **compatible Windows + débutant**, donc **on évite toute chaîne LaTeX complète locale**.*

## Principe de rendu : éviter LaTeX, préférer « zéro/léger install »

Le PDF depuis Markdown ne nécessite **pas** LaTeX. Backends classés pour une promo hétérogène (dont Windows) :

| Backend | Poids / install | Windows | Verdict |
|---------|-----------------|---------|---------|
| **pandoc `--pdf-engine=typst`** | binaire **~30 Mo unique** | ✅ facile | ✅✅ **Voie cœur recommandée**. ~27× plus rapide que xelatex. Cohérent avec l'extension Typst. |
| **tectonic** | moteur TeX auto-suffisant | ✅ | ✅ alternative légère |
| **TinyTeX** | ~100 Mo, cross-platform | ✅ | ✅ si on veut un backend LaTeX léger |
| route HTML→PDF (**weasyprint** / **wkhtmltopdf**) | moyen | 🔶 | ⚪ possible, dépendances |
| **pandoc + xelatex / TeX Live complet** | plusieurs **Go** | ❌ pénible | ❌ **à éviter** comme défaut |

Réf. : [pandoc — PDF engines](https://pandoc.org/MANUAL.html) · [Typst comme moteur pandoc (slhck.info)](https://slhck.info/software/2025/10/25/typst-pdf-generation-xelatex-alternative.html) · [tutoriel pandoc+typst](https://imaginarytext.ca/posts/2024/pandoc-typst-tutorial/).

## Voie 1 — CV en Markdown (exercice cœur, EX3)

| Ressource | Vérifié | Rôle proposé | Lien |
|-----------|---------|--------------|------|
| **Markdown + `pandoc --pdf-engine=typst`** | — | **Voie cœur** : écrire le contenu en `.md`, rendre en PDF sans LaTeX. Enseigne la chaîne fichier→CLI→PDF (valeur git/CLI). | (chaîne d'outils, pas un repo) |
| **elipapa/markdown-cv** | 1,5k★, Jekyll, maintenance ralentie | Option **zéro-install via GitHub Pages** (pas de Jekyll local) : « j'édite, je push, ça s'affiche ». | https://github.com/elipapa/markdown-cv · https://elipapa.github.io/markdown-cv/ |
| **junian/markdown-resume** | 627★, actif, **web PWA offline**, PDF/HTML/DOCX, ATS | Option **zéro-install Windows** pour les plus en difficulté. *Réserve* : web-app → enseigne peu la chaîne CLI. | https://github.com/junian/markdown-resume |
| **tompollard/markdown-cv** | 112★, pandoc **+ LaTeX**, CI legacy | 🔻 **Secondaire** : n'utiliser que si on remplace son moteur par Typst ; sinon friction Windows. | https://github.com/tompollard/markdown-cv |

*Écartés (sans fond / trivial / dépendance à une extension) : tengjuilin/markdown-resume, markdownresume/markdown-resume-templates, pages « topic » GitHub.*

## Voie 2 — CV en Typst (extension avancée, AV2)

**Astuce Windows** : l'**app web [typst.app](https://typst.app/)** compile en ligne → **zéro install**, contourne polices/CLI.

| Ressource | Vérifié | Rôle | Lien |
|-----------|---------|------|------|
| **basic-resume** | v0.2.9 (sept. 2025), actif, ATS, **code commenté**, domaine public | ✅✅ **Débutant** : meilleur point de départ. | https://typst.app/universe/package/basic-resume/ |
| **modern-cv** | v0.10.0 (avr. 2026), actif, séparation données/présentation via objets de config | ✅ **Défaut visuel** (port Awesome-CV). | https://typst.app/universe/package/modern-cv/ |
| **brilliant-cv** | v4.0.1 (mai 2026), **CI 40+ tests**, données **TOML**, **variants de profil** (`--input profile=fr`) | ✅✅ **Priorité pédagogique** : illustre *directement* séparation données/présentation **et** l'idée d'anonymisation (AV1). | https://typst.app/universe/package/brilliant-cv/ |
| **awesome-typst** (qjcg) | collection curée communauté | ⚪ Point d'entrée « pour aller plus loin ». | https://github.com/qjcg/awesome-typst |

*Optionnels : neat-cv, mrbogo-cv (esthétiques). quarto-awesomecv-typst = ajoute Quarto → avancé seulement.*

## « Vrai outil » (bouclage)

- **RenderCV** — pip, YAML → Typst → PDF/LaTeX/HTML/PNG. « Votre script jouet, en version produit. » https://docs.rendercv.com/
- **JSON Resume** — fichier de données standard + thèmes. https://jsonresume.org/

## Fil directeur pour les étudiants

> Un CV = **données** (qui je suis) + **présentation** (comment ça s'affiche). Markdown+pandoc, Typst, RenderCV : trois niveaux de séparation croissante des deux. **Cette séparation est le concept réutilisable**, bien au-delà du CV. Et techniquement : **Typst est le fil commun** (moteur de pandoc en voie cœur, puis langage à part entière en avancé).
