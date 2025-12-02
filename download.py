import os
from pathlib import Path
from urllib.request import urlopen, Request
from urllib.error import URLError, HTTPError
import shutil
import sys

URL_LIST = Path(r"C:\Users\ggenelot\Nouveau dossier\Hackathon-climat-github\liste_fichier_2042_2061.txt")
DEST_DIR = Path("data/downloads")
CHUNK = 1024 * 1024  # 1 MB chunks

def read_urls(path: Path):
    if not path.exists():
        raise FileNotFoundError(f"URL list file not found: {path}")
    with path.open(encoding="utf-8") as f:
        for line in f:
            u = line.strip()
            if not u or u.startswith("#"):
                continue
            yield u

def format_mb(nbytes):
    return f"{nbytes / (1024*1024):6.1f} MB"

def download(url: str, dest: Path, timeout: int = 60):
    dest.parent.mkdir(parents=True, exist_ok=True)
    req = Request(url, headers={"User-Agent": "python-downloader"})
    try:
        with urlopen(req, timeout=timeout) as resp, dest.open("wb") as out:
            total = resp.headers.get("Content-Length")
            total = int(total) if total is not None else None
            downloaded = 0

            while True:
                chunk = resp.read(CHUNK)
                if not chunk:
                    break
                out.write(chunk)
                downloaded += len(chunk)

                if total:
                    pct = downloaded / total * 100
                    bar = f"{pct:5.1f}% {format_mb(downloaded)}/{format_mb(total)}"
                else:
                    bar = f"{format_mb(downloaded)} (total ?)"

                # carriage return to update in place
                sys.stdout.write(f"\r{url.split('/')[-1]} -> {bar}")
                sys.stdout.flush()

        sys.stdout.write("\n")
        print(f"OK  {url} -> {dest}")
    except HTTPError as e:
        print(f"HTTP error {e.code} for {url}")
    except URLError as e:
        print(f"URL error {e.reason} for {url}")
    except Exception as e:
        print(f"Failed {url}: {e}")

def main():
    for url in read_urls(URL_LIST):
        fname = url.split("/")[-1]
        target = DEST_DIR / fname
        download(url, target)

if __name__ == "__main__":
    main()
