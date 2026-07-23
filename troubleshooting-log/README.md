# Troubleshooting Log

Journal de résolution de problèmes techniques rencontrés au quotidien.
Objectif : documenter la méthode de diagnostic, pas seulement la solution finale.

---


# Incident: GitHub Action resolution failure — `deploy-pages@v4`

**Date:** 2026-07-23
**Project:** Portfolio deployment (`.github/workflows/portfolio-deploy.yml`)

## Symptom

The "Deploy Portfolio" workflow failed with:


## Investigation

- Verified the YAML syntax and action reference — no typo, correct spelling.
- Checked official documentation for `actions/upload-pages-artifact`: `@v3` is the current recommended tag, and requires `actions/deploy-pages@v4` or newer.
- Ruled out a real deprecation issue (the action was working fine in previous runs).

## Attempted fixes

1. Downgraded `actions/deploy-pages` from `@v4` to `@v1` (suggested by GitHub Copilot) — worked once, but contradicted official docs (v3 artifact requires v4+ deploy-pages), so kept as suspicious.
2. Tried `actions/deploy-pages@v3` — pipeline failed.
3. Reverted to the original `actions/deploy-pages@v4` and re-pushed — **pipeline succeeded**, site deployed correctly.

## Root cause

Most likely a **transient GitHub Actions infrastructure issue** (temporary problem resolving the `v4` tag or a related dependency at that specific moment), not a real configuration or code issue. The original, officially recommended configuration (`deploy-pages@v4`) worked correctly once retried.

## Resolution

No code change was ultimately needed. The fix was simply **retrying** (re-running the workflow / pushing again) rather than changing the action version.

## Lesson learned

When a GitHub Action that was previously working suddenly fails with a "repository or version not found" error, the first step should be to **retry** (re-run the job, or trigger a new push) before changing action versions. Downgrading versions based on trial and error can introduce inconsistencies with official documentation and may only appear to "work" due to unrelated factors.

---

## 2026-07-23 — Steam refuse de s'installer sur Ubuntu 25.10

### Symptôme
`sudo apt install --reinstall steam-installer` échoue avec une erreur de dépendances :

steam-installer : Depends: steam-libs-i386 (= 1:1.0.0.83~ds-3) but it is not installable

### Diagnostic
1. Vérification de l'architecture i386 :
```bash
   dpkg --print-foreign-architectures
   sudo dpkg --add-architecture i386
```
2. Analyse des sources en conflit sur le paquet :
```bash
   apt-cache policy steam-libs-i386
```
   Résultat : deux dépôts proposaient des versions différentes du même paquet
   (Kali Linux `1.0.0.87~ds-2` vs Ubuntu `1.0.0.83~ds-3`).
3. Vérification du système et des sources actives :
```bash
   cat /etc/os-release
   ls /etc/apt/sources.list.d/
```
   Système : Ubuntu 25.10, avec un dépôt Kali Linux ajouté en supplément
   (`kali.list`), créant un conflit de versions sur les dépendances i386.

### Cause racine
Mélange de dépôts APT incompatibles (Ubuntu + Kali Linux) provoquant un
conflit de résolution de dépendances sur les paquets 32-bit requis par Steam.

### Solution
Plutôt que de réparer le pinning APT (solution plus longue et fragile),
installation de Steam via Flatpak, qui isole les dépendances de l'app
du système :
```bash
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.valvesoftware.Steam
flatpak run com.valvesoftware.Steam
```

### Ce que j'ai appris
- `apt-cache policy <paquet>` permet de voir toutes les sources en
  compétition pour un paquet donné, essentiel pour diagnostiquer les
  conflits de dépôts.
- Mélanger des dépôts de distributions différentes (Ubuntu + Kali) est
  risqué pour la stabilité du système.
- Flatpak est une bonne solution de contournement quand un conflit de
  dépendances système est complexe à résoudre proprement.


