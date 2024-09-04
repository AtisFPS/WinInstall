[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProjectName = "WinSetup"
$host.UI.RawUI.WindowTitle = "$ProjectName - Atis"

$temp           = "$env:TEMP"
$setupURL      = "https://raw.githubusercontent.com/AtisFPS/WinSetup/main/setup"
$cdnURL        = "https://raw.githubusercontent.com/AtisFPS/WinSetup/main/upload/"
$ScriptsPath = "$scriptURL/"

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName 'System.Windows.Forms'
Add-Type -AssemblyName 'System.Drawing'
Import-Module -Name PowerShellGet
Install-Module -Name WindowsDesktopBackground
Add-Type -AssemblyName PresentationCore,PresentationFramework

function EchoToolsBox {
    Clear-Host
    Write-Host ''
    Write-Host 'Tout telechargement sera effectue dans les dossier temporaire ou dans vos images '
    Write-Host ''
    Write-Host '    $$\      $$\ $$\                   $$$$$$\             $$\                         '
    Write-Host '    $$ | $\  $$ |\__|                 $$  __$$\            $$ |                        '
    Write-Host '    $$ |$$$\ $$ |$$\ $$$$$$$\         $$ /  \__| $$$$$$\ $$$$$$\   $$\   $$\  $$$$$$\  '
    Write-Host '    $$ $$ $$\$$ |$$ |$$  __$$\ $$$$$$\\$$$$$$\  $$  __$$\\_$$  _|  $$ |  $$ |$$  __$$\ '
    Write-Host '    $$$$  _$$$$ |$$ |$$ |  $$ |\______|\____$$\ $$$$$$$$ | $$ |    $$ |  $$ |$$ /  $$ |'
    Write-Host '    $$$  / \$$$ |$$ |$$ |  $$ |       $$\   $$ |$$   ____| $$ |$$\ $$ |  $$ |$$ |  $$ |'
    Write-Host '    $$  /   \$$ |$$ |$$ |  $$ |       \$$$$$$  |\$$$$$$$\  \$$$$  |\$$$$$$  |$$$$$$$  |'
    Write-Host '    \__/     \__|\__|\__|  \__|        \______/  \_______|  \____/  \______/ $$  ____/ '
    Write-Host '                                                                             $$ |      '
    Write-Host '                                                                             $$ |      '
    Write-Host '                                                                             \__|      '
    Write-Host ''
    Write-Host ''
    Write-Host ''
    Write-Host '--'
    Write-Host 'Script mis a jour regulierement'
    Write-Host 'Certaines fonction sont des scripts GitHub directement integrer'
    Write-Host '----------------------------------------------------------------'
    Write-Host 'Made by Hugo SERRURE'
    Write-Host '--'
    Write-host 'Github : https://github.com/AtisFPS/WinSetup'
    Write-Host 'https://hserrure.poupli.net/'
    Write-Host '--'
    Write-Host 'Contact : hserrure@poupli.net'
    Write-Host 'All right reserved'
    Write-Host '--'
}

function Winget-Setup {
    $winget = "./setup/winget.ps1"
    Start-Process powershell.exe -ArgumentList "-NoProfile -WindowStyle Minimized -ExecutionPolicy Bypass -File `"$winget`"" -Verb RunAs
}

function Graph-Install {
    EchoToolsBox
    #############################################################
    #               Menu Principal                              #
    #############################################################
    
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "$ProjectName - Menu Principal"
    $form.Size = New-Object System.Drawing.Size(400, 650)
    # Defini le logo comme icone de la fenetre
    $form.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap $LogoPath).GetHicon())
    # Defini le fond d ecran de la fenetre
    $form.BackgroundImage = [System.Drawing.Image]::FromFile($BackgroundPath)
    $form.BackgroundImageLayout = "Stretch"
    $form.StartPosition = "CenterScreen"  

    ##########################################################################
     #   Affiche le panneau de configuration
     $buttonOutils = New-Object System.Windows.Forms.Button
     $buttonOutils.Text = "Outils d'administration Windows "
     $buttonOutils.Size = New-Object System.Drawing.Size(300, 30)
     $buttonOutils.Location = New-Object System.Drawing.Point(50, 20)
     $buttonOutils.Add_Click({
         UtilsFunction
     })
     $form.Controls.Add($buttonOutils)
    
    ##########################################################################
    # Creer un bouton "Quitter"
    $buttonQuitter = New-Object System.Windows.Forms.Button
    $buttonQuitter.Text = "Quitter"
    $buttonQuitter.Size = New-Object System.Drawing.Size(300, 30)
    $buttonQuitter.Location = New-Object System.Drawing.Point(50, 570)
    $buttonQuitter.Add_Click({
        $form.Close()
    })

    # Ajouter le bouton "Quitter" a la fenetre
    $form.Controls.Add($buttonQuitter)
    
    ##########################################################################
    
    # Afficher la fenetre
    $form.ShowDialog()
}
function Graph-Cache {
    $LogoUrl = "$cdnURL/logo-tools.png"
    $LogoPath = "$temp/logo-tools.png"
    $BackgroundURL = "$cdnURL/background-tools.jpg"
    $BackgroundPath = "$temp/background-tools.jpg"

 if (Test-Path $BannerSanctionPath) {
    $buttonSanctionRapide.BackgroundImage = [System.Drawing.Image]::FromFile($BannerSanctionPath)
} else {
    Write-Host "Erreur: Le fichier $BannerSanctionPath n'existe pas."
}

    if (-not (Test-Path $BackgroundPath)) {
        $wc = New-Object System.Net.WebClient
        try {
            $wc.DownloadFile($BackgroundURL, $BackgroundPath)
        } catch {
            Write-Host "Erreur lors du téléchargement du fond d'écran."
        }
    }
    if (-not (Test-Path $LogoPath)) {
        $wc = New-Object System.Net.WebClient
        try {
            $wc.DownloadFile($LogoUrl, $LogoPath)
        } catch {
            Write-Host "Erreur lors du téléchargement du fond d'écran."
        }
    }
}
Graph-Install
EchoToolsBox
#Winget-Setup