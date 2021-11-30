## Requis:
* Avoir Docker d'installer
* Avoir Vscode
* Installer l'extension Docker
* Installer l'extension Remote-container de Vscode
* Si vous avez Wsl2, installer Remote-WSL

## Commencer le travail
Lorsque vous êtes dans le container avec Vscode, voici les étapes à suivre:

Installer les extensions recommandées (optionnel, mais conseillé)

Ouvrir un terminal de vscode
1. Utiliser la commande julia start-jupyter.jl dans le terminal
2. Une page dans vscode va s'ouvrir avec des liens, faites CTRL+CLICK sur le lien pour vous rediriger sur un browser avec Jupyter d'installer.
3. Si une page n'apparait pas veuillez faire la commande `jupyter notebook list` pour lister les serveurs qui roule en ce moment et auquel vous pouvez vous connecter

**Petite règle bien importante si vous ne voulez pas perdre vos fichiers/travaux. Mettre tous les fichiers/dossiers que vous voulez retrouver dans le répertoire Jupyter dans le dossier *jupyter-folder*.**