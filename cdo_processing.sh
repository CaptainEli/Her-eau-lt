#!/bin/bash

var="pr_hist"
chemin="data/downloads/${var}"
chemin_out="data/processed/${var}"

mkdir -p "$chemin_out"

echo "=== Début du traitement individuel ==="

# Boucle sur tous les fichiers .nc du dossier
for file in "$chemin"/*.nc; do
    filename=$(basename "$file")
    output_tmp="tmp_${filename}"

    echo "Traitement de : $filename"

    # Étape 1 : extraction lon/lat
    cdo -sellonlatbox,2.0,4.8,42.9,44.2 "$file" "$output_tmp"

    # Étape 2 : daysum du fichier découpé
    cdo -daysum "$output_tmp" "${chemin_out}/processed_${filename}"

    rm "$output_tmp"
done

echo "=== Traitement individuel terminé ==="
echo "=== Merger tous les fichiers produits ==="

#  Étape finale : daysum global sur tous les fichiers créés
final_output="${chemin_out}/${var}_merged.nc"
cdo -mergetime ${chemin_out}/processed_*.nc "$final_output"

echo "Fichier final créé : $final_output"
