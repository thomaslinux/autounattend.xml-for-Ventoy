# Introduction

Une organisation de dossier pour un Volume de préparations de postes Windows avec Ventoy

# Prérequis

- [Ventoy](https://www.ventoy.net/en/download.html)
- Une clé USB / volume externe rapide et vide

# Setup

1. Lancez Ventoy
1. Branchez le volume
1. Installez Ventoy sur le volume
1. Copiez coller tous les fichiers du repo sur le volume
1. Téléchargez une ISO Windows dans ISO\Windows
https://www.microsoft.com/fr-ca/software-download/windows11#SoftwareDownload_Edition


# Reset with unattend from running PC
1. Disable bitlocker
2. Uninstall Sentinel One (if impossible, [Reset from oobe](https://github.com/thomaslinux/unattend.xml/blob/main/README.md#reset-from-oobe))
1. Open Templates folder on your usb key and run ``ADMIN reset.cmd``
2. Reset should happen with unattend

# Reset from oobe
After asking the PC for reset, on OOBE screen
Shift + F10
Focus the cmd window (Alt + Tab) or click on it
```batch
D:
cd Templates
"ADMIN reset.cmd"
```

# Credits
Me

Ventoy

https://schneegans.de/windows/unattend-generator/
