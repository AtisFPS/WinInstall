# Vérifier si Winget est déjà installé
try {
    $wingetVersion = winget --version
    if ($wingetVersion) {
        Write-Output "Winget est déjà installé. Version : $wingetVersion"
        return
    }
}
catch {
    Write-Output "Winget n'est pas installé. Procédure d'installation en cours..."
}

# Définir l'URL du dernier App Installer depuis le GitHub de Microsoft Winget
$githubUrl = "https://github.com/microsoft/winget-cli/releases/latest"
$outputFile = "$env:TEMP\winget-installer.msixbundle"

try {
    # Télécharger le fichier d'installation
    Write-Output "Téléchargement de Winget depuis GitHub..."
    Invoke-WebRequest -Uri $githubUrl -OutFile $outputFile -UseBasicParsing

    # Extraire l'URL du fichier msixbundle
    $installerUrl = (Invoke-WebRequest -Uri $githubUrl -UseBasicParsing).Links |
                    Where-Object { $_.href -match "msixbundle" } |
                    Select-Object -First 1 -ExpandProperty href

    # Télécharger le fichier msixbundle
    Write-Output "Téléchargement du fichier d'installation..."
    Invoke-WebRequest -Uri $installerUrl -OutFile $outputFile

    # Installer le fichier .msixbundle
    Write-Output "Installation de Winget..."
    Add-AppxPackage -Path $outputFile

    # Vérifier l'installation
    $wingetVersion = winget --version
    if ($wingetVersion) {
        Write-Output "Installation réussie. Winget version : $wingetVersion"
    } else {
        Write-Output "L'installation a échoué. Veuillez vérifier les permissions ou installer manuellement."
    }
}
catch {
    Write-Error "Une erreur est survenue : $_"
}