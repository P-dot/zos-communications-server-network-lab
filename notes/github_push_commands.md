# Git Bash publish commands

Run these from Git Bash after copying this folder into your portfolio directory.

```bash
cd /c/Carrera_Ciberseguridad/06_Portfolio_GitHub

# If the folder is already here:
cd zos-communications-server-network-lab

git init
git add README.md docs scripts evidence/sanitized .gitignore
git status

git commit -m "Add sanitized zOS Communications Server network evidence lab"

# Create a GitHub repo first, for example:
# https://github.com/P-dot/zos-communications-server-network-lab

git branch -M main
git remote add origin https://github.com/P-dot/zos-communications-server-network-lab.git
git push -u origin main
```

Before `git push`, verify that `git status` does not include raw screenshots, transcripts, IP dumps, or emulator configuration files.
