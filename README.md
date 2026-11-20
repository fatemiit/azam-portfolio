# Azam Esmaeili — Portfolio

Static export of the Framer site published at https://azamesmaili.framer.website,
served by GitHub Pages. Framer is the source of truth; this repo is the hosting copy.

## Updating after a Framer change

1. Publish in Framer.
2. Either run `bash _tools/sync.sh` locally and commit, or open **Actions → Sync from Framer → Run workflow**.
   The workflow also runs once a day on its own.

`sync.sh` reads the Framer sitemap, so new pages are picked up automatically.

## Connecting a custom domain

1. Add a `CNAME` file at the repo root containing only the domain, e.g. `azamesmaili.com`, then run the sync
   (it rewrites canonical URLs, sitemap and robots.txt to that domain).
2. DNS at the registrar:
   - Apex: four `A` records → `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
   - `www`: `CNAME` → `<github-username>.github.io`
3. Settings → Pages → Custom domain → enter it → **Enforce HTTPS**.
