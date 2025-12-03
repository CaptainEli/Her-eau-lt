chemin_out="data/processed/pr"
final_output="precip_merged.nc"


cdo -mergetime ${chemin_out}/processed_*.nc "$final_output"
