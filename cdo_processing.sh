chemin="data"
file="C:\Users\ggenelot\Nouveau dossier\Hackathon-climat-github\data\prAdjust_FR-Metro_CNRM-ESM2-1_ssp370_r1i1p1f2_CNRM-MF_CNRM-AROME46t1_v1-r1_MF-CDFt-COMEPHORE-ALPX-3-1997-2020_1hr_201601010030-201612312330.nc"
chemin_out="data\processed"
output_file="output.nc"


cdo -f nc -setmissval,0 -remapnn,${chemin}/${file} -shp2grid,data/shape/departements-20140306-100m.shp herault_mask.nc
cdo -O -ifthen herault_mask.nc ${chemin}/${file} ${chemin_out}/${output_file}
