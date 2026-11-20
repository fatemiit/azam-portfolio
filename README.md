# Azam Esmaeili — Portfolio

Product designer portfolio. The site is designed and edited in **Framer** and published at
https://azamesmaili.framer.website.

This repo mirrors that published site to **GitHub Pages**, so it can run on a custom domain
without a paid Framer plan.

## How it works

- `.github/workflows/deploy.yml` downloads every page of the Framer site and deploys it to GitHub Pages.
- It runs on every push to `main`, once a day, and on demand (Actions → *Mirror Framer site* → *Run workflow*).
- Images, fonts and scripts still load from Framer's CDN, so the mirror looks and behaves like the original.

**To update the site:** edit and publish in Framer, then run the workflow (or wait for the daily run).

**Adding a page in Framer:** add its path to the `for path in ...` list in the workflow.

## Connecting a custom domain

1. Add a file named `CNAME` at the repo root containing only the domain, e.g. `azamesmaili.com`.
2. At the domain registrar, add DNS records:
   - Apex domain (`azamesmaili.com`): four `A` records → `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
   - `www`: a `CNAME` record → `<github-username>.github.io`
3. Repo Settings → Pages → Custom domain → enter the domain → tick **Enforce HTTPS** once the certificate is ready.

## Pages

| Path | Page |
|---|---|
| `/` | Home |
| `/case-studies` | Case studies |
| `/case-studies/okala-out-of-stock` | Okala case study |
| `/case-studies/nobitex-shortcuts` | Nobitex case study |
| `/experience` | Experience |
| `/about` | About |
