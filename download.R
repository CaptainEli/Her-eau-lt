urls <- c(
  "https://object.files.data.gouv.fr/meteofrance-drias/SocleM-Climat-2025/CPRCM/METROPOLE/ALPX-3/CNRM-ESM2-1/r1i1p1f2/CNRM-AROME46t1/ssp370/1hr/prAdjust/version-hackathon-102025/prAdjust_FR-Metro_CNRM-ESM2-1_ssp370_r1i1p1f2_CNRM-MF_CNRM-AROME46t1_v1-r1_MF-CDFt-COMEPHORE-ALPX-3-1997-2020_1hr_201601010030-201612312330.nc",
  "https://object.files.data.gouv.fr/meteofrance-drias/SocleM-Climat-2025/CPRCM/METROPOLE/ALPX-3/CNRM-ESM2-1/r1i1p1f2/CNRM-AROME46t1/ssp370/1hr/prAdjust/version-hackathon-102025/prAdjust_FR-Metro_CNRM-ESM2-1_ssp370_r1i1p1f2_CNRM-MF_CNRM-AROME46t1_v1-r1_MF-CDFt-COMEPHORE-ALPX-3-1997-2020_1hr_204201010030-204212312330.nc",
  "https://example.com/image.png"
)

dest_dir <- "data/downloads"

if (!dir.exists(dest_dir)) dir.create(dest_dir, recursive = TRUE)


download_files <- function(urls, dest_dir) {
  if (!dir.exists(dest_dir)) dir.create(dest_dir, recursive = TRUE)

  for (u in urls) {
    fname <- basename(u)
    dest_path <- file.path(dest_dir, fname)
    message("Downloading ", u, " -> ", dest_path)
    tryCatch(
      {
        download.file(u, destfile = dest_path, mode = "wb", quiet = FALSE)
      },
      error = function(e) message("Failed to download ", u, ": ", e$message)
    )
  }
}

for (u in urls) {
  fname <- basename(u)
  dest_path <- file.path(dest_dir, fname)
  message("Downloading ", u, " -> ", dest_path)
  tryCatch(
    download.file(u, destfile = dest_path, mode = "wb", quiet = FALSE),
    error = function(e) message("Failed to download ", u, ": ", e$message)
  )
}




