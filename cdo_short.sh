chemin="data"
file="data\prAdjust_FR-Metro_CNRM-ESM2-1_ssp370_r1i1p1f2_CNRM-MF_CNRM-AROME46t1_v1-r1_MF-CDFt-COMEPHORE-ALPX-3-1997-2020_1hr_201601010030-201612312330.nc"
chemin_out="data\processed"
output_file="output.nc"


cdo -sellonlatbox,2.0,4.8,42.9,44.2 data/prAdjust_FR-Metro_CNRM-ESM2-1_ssp370_r1i1p1f2_CNRM-MF_CNRM-AROME46t1_v1-r1_MF-CDFt-COMEPHORE-ALPX-3-1997-2020_1hr_201601010030-201612312330.nc output_herault.nc
