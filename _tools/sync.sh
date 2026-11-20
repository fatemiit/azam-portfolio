#!/usr/bin/env bash
# Re-export the live Framer site into this repo. Run from repo root: bash _tools/sync.sh
set -euo pipefail
SRC=https://azamesmaili.framer.website
ROOT=$(pwd)
DOMAIN=$( [ -f "$ROOT/CNAME" ] && tr -d '[:space:]' < "$ROOT/CNAME" || true )
TMP=$(mktemp -d)
curl -sS "$SRC/sitemap.xml" -o "$TMP/sitemap.xml"
# Framer's sitemap may list the primary host (e.g. *.framer.app), not $SRC
ORIGIN=$(grep -o '<loc>[^<]*' "$TMP/sitemap.xml" | head -1 | sed -E 's#<loc>(https?://[^/]+).*#\1#')
grep -o '<loc>[^<]*' "$TMP/sitemap.xml" | sed 's#<loc>##' | while read -r loc; do
  p=$(echo "$loc" | sed -E 's#^https?://[^/]+/?##')
  url="$SRC/$p"
  mkdir -p "$TMP/site/$p"
  for i in 1 2 3; do
    curl -sS "$url" -o "$TMP/site/$p/index.html"
    [ "$(stat -c%s "$TMP/site/$p/index.html")" -gt 60000 ] && break
    sleep 3
  done
  echo "fetched /$p ($(stat -c%s "$TMP/site/$p/index.html") bytes)"
done
python3 -I "$ROOT/_tools/process.py" "$TMP/site" "$DOMAIN" "$ORIGIN" >/dev/null
if [ -n "$DOMAIN" ]; then
  python3 -I "$ROOT/_tools/process.py" "$TMP/site" "$DOMAIN" "$SRC" >/dev/null
  sed -e "s#$ORIGIN#https://$DOMAIN#g" -e "s#$SRC#https://$DOMAIN#g" "$TMP/sitemap.xml" > "$TMP/site/sitemap.xml"
  printf 'User-agent: *\nAllow: /\nSitemap: https://%s/sitemap.xml\n' "$DOMAIN" > "$TMP/site/robots.txt"
fi
cp "$TMP/site/index.html" "$TMP/site/404.html"
# replace old pages, keep repo-only files
find "$ROOT" -mindepth 1 -maxdepth 1 ! -name .git ! -name .github ! -name _tools ! -name _icons ! -name favicon.ico ! -name CNAME ! -name .nojekyll ! -name README.md -exec rm -rf {} +
cp -r "$TMP/site/." "$ROOT/"
touch "$ROOT/.nojekyll"
rm -rf "$TMP"
echo done
