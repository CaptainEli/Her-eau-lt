# Read URLs from file (ignores blank lines and lines starting with #)
urls_file <- "liste_fichier_2042_2061.txt"
if (!file.exists(urls_file)) stop("URL list file not found: ", urls_file)

urls <- readLines(urls_file, warn = FALSE, encoding = "UTF-8")
urls <- trimws(urls)
urls <- urls[urls != "" & !grepl("^\\s*#", urls)]
if (length(urls) == 0) stop("No URLs found in ", urls_file)

dest_dir <- "data"

download_files <- function(urls, dest_dir) {
  if (!dir.exists(dest_dir)) dir.create(dest_dir, recursive = TRUE)

  for (u in urls) {
    fname <- basename(u)
    dest_path <- file.path(dest_dir, fname)
    message("Downloading ", u, " -> ", dest_path)
    tryCatch(
      download.file(u, destfile = dest_path, mode = "wb", quiet = FALSE),
      error = function(e) message("Failed to download ", u, ": ", e$message)
    )
  }
}

download_files(urls, dest_dir)




