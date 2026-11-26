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

# Utilisation normale

- Démarrez sur le volume Ventoy
- Sélectionnez Windows
- démarrage normal ou wimboot (en fonction de ce qui marche)
- charger avec le modèle de template autounattend.xml

Le reset devrait se dérouler, la seule question sera le nom du poste.

<details><summary>

## Utilisation alternative
</summary>

Si vous ne pouvez pas démarrer sur le poste uniquement
<details><summary>

## Reset with unattend from running PC
</summary>

1. Disable bitlocker
1. Uninstall Sentinel One (if impossible, [Reset from oobe](https://github.com/thomaslinux/unattend.xml/blob/main/README.md#reset-from-oobe))
1. Open Templates folder on your usb key and run ``ADMIN reset.cmd``
1. Reset should happen with unattend

</details>

<details><summary>
  
## Reset from oobe
</summary>

After asking the PC for reset, on OOBE screen
Shift + F10
Focus the cmd window (Alt + Tab) or click on it
```batch
D:
cd Templates
"ADMIN reset.cmd"
```

</details>
</details>

# Credits
thomaslinux

Claude

Ventoy

https://schneegans.de/windows/unattend-generator/
