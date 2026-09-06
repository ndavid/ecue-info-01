#!/usr/bin/env bash
# Fabrique trajet.mp4 à partir de carte.png et etapes.csv.
#
#   ./anime.sh
#
# Une image par étape (ImageMagick), un fichier de sous-titres construit à
# partir des mêmes durées, puis le montage (ffmpeg). Chaque étape produit un
# fichier que l'étape suivante consomme : c'est ce que la manipulation montre.

set -euo pipefail
cd "$(dirname "$0")"
rm -f etape_*.png trajet.srt montage.txt trajet.mp4

# 1. lire les étapes
mapfile -t lignes < <(tail -n +2 etapes.csv)
xs=(); ys=(); durees=(); textes=()
for ligne in "${lignes[@]}"; do
  IFS=, read -r _numero duree x y texte <<< "$ligne"
  xs+=("$x"); ys+=("$y"); durees+=("$duree"); textes+=("$texte")
done
dernier=$((${#xs[@]} - 1))

# 2. une image par étape : le chemin déjà parcouru en bleu, l'étape en cours en orange
for i in $(seq 1 $dernier); do
  arguments=(carte.png -fill none)
  for j in $(seq 1 $((i - 1))); do
    arguments+=(-stroke '#1f6f8bAA' -strokewidth 6
                -draw "line ${xs[$((j - 1))]},${ys[$((j - 1))]} ${xs[$j]},${ys[$j]}")
  done
  arguments+=(-stroke '#d95f02' -strokewidth 9
              -draw "line ${xs[$((i - 1))]},${ys[$((i - 1))]} ${xs[$i]},${ys[$i]}"
              -stroke none
              -fill '#d95f02' -draw "circle ${xs[$i]},${ys[$i]} $((xs[i] + 9)),${ys[$i]}"
              -fill '#1f6f8b' -draw "circle ${xs[0]},${ys[0]} $((xs[0] + 9)),${ys[0]}")
  magick "${arguments[@]}" "$(printf 'etape_%02d.png' "$i")"
done

# 3. le fichier de sous-titres : un bloc par étape, aux mêmes durées
instant=0
: > trajet.srt
for i in $(seq 1 $dernier); do
  fin=$((instant + durees[i]))
  printf '%d\n00:%02d:%02d,000 --> 00:%02d:%02d,000\n%s\n\n' \
    "$i" $((instant / 60)) $((instant % 60)) $((fin / 60)) $((fin % 60)) "${textes[$i]}" \
    >> trajet.srt
  instant=$fin
done

# 4. la liste de montage : chaque image tient la durée de son étape
: > montage.txt
for i in $(seq 1 $dernier); do
  printf "file '%s'\nduration %d\n" "$(printf 'etape_%02d.png' "$i")" "${durees[$i]}" \
    >> montage.txt
done
printf "file '%s'\n" "$(printf 'etape_%02d.png' "$dernier")" >> montage.txt

# 5. le montage, sous-titres incrustés
ffmpeg -y -loglevel error -f concat -safe 0 -i montage.txt \
  -vf "subtitles=trajet.srt:force_style='FontSize=11,Outline=1.5,MarginV=16',format=yuv420p" \
  -r 25 trajet.mp4

echo "trajet.mp4 : $(ffprobe -v error -show_entries format=duration -of csv=p=0 trajet.mp4) s"
