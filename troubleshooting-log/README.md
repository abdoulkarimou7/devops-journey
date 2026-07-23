# Troubleshooting Log

Journal de résolution de problèmes techniques rencontrés au quotidien.
Objectif : documenter la méthode de diagnostic, pas seulement la solution finale.

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
