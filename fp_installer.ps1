If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}

echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo "--------------------------------------------------------"
echo ""
echo "Installateur de Adobe Flash Player par Timothée Danneels"
echo ""
echo "https://tidann.dev              Mis à jour le 28/01/2020"
echo ""
echo "--------------------------------------------------------"
echo ""
echo "L'installateur va télécharger Adobe Flash Player depuis"
echo "le lien à l'adressse : https://www.adobe.com/support/"
echo "flashplayer/debug_downloads.html"
echo ""
echo "L'installateur va ensuite créer des raccourcis du"
echo "programme sur le bureau et dans le menu Démarrer, puis"
echo "associer les fichiers SWF au programme."
echo ""
echo "Une connexion Internet ainsi que des droits"
echo "Administrateur sont requis."
echo ""

cd "C:\Program Files"
mkdir FlashPlayerProject
cd FlashPlayerProject
Invoke-WebRequest "https://fpdownload.macromedia.com/pub/flashplayer/updaters/32/flashplayer_32_sa.exe" -OutFile flashplayer_32_sa.exe

$SourceFileLocation = "C:\Program Files\FlashPlayerProject\flashplayer_32_sa.exe"
$DesktopShortcut = "C:\Users\Public\Desktop\Flash Player.lnk"
$StartMenuShortcut = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Flash Player.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell

$DShortcut = $WScriptShell.CreateShortcut($DesktopShortcut)
$DShortcut.TargetPath = $SourceFileLocation
$DShortcut.Save()

$SMShortcut = $WScriptShell.CreateShortcut($StartMenuShortcut)
$SMShortcut.TargetPath = $SourceFileLocation
$SMShortcut.Save()

cmd /c assoc .swf=FlashPlayerFile.Document
cmd /c --% ftype FlashPlayerFile.Document="C:\Program Files\FlashPlayerProject\flashplayer_32_sa.exe" "%1"

echo ""
echo "Terminé !"
echo ""

pause