@echo off
rem ============================================================================
rem  collecte.cmd : releve l'etat d'un poste Windows pour le module info01
rem ============================================================================
rem
rem  QUOI      Ecrit dans un fichier texte tout ce qu'il faut savoir pour
rem            comprendre pourquoi VS Code, conda, Navigator ou Jupyter ne
rem            marchent pas sur ce poste : reseau, versions, reglages,
rem            chemins, journaux. Onze sections, numerotees de 0 a 10.
rem
rem  COMMENT   Double-cliquer sur ce fichier. Il ne pose aucune question, ne
rem            modifie rien, et se termine par le mot "Termine". Compter une
rem            a deux minutes. Si le double-clic ne fait rien, ouvrir un cmd
rem            (menu Demarrer, taper cmd), y glisser ce fichier, puis Entree.
rem
rem  RESULTAT  Un fichier diagnostic_<poste>_<compte>.txt, ecrit a cote de ce
rem            script si le dossier accepte l'ecriture, sinon sur le Bureau,
rem            sinon a la racine du profil. Le chemin est affiche a la fin.
rem            Dans le rapport, chaque section commence par une ligne
rem            "Ce qu'on regarde" qui dit quoi y lire.
rem
rem  LIMITES   Aucun droit d'administrateur n'est necessaire. Les commandes
rem            PowerShell sont passees avec -Command : la strategie Restricted
rem            les autorise, elle ne bloque que les fichiers .ps1.
rem            Pas d'accent dans ce fichier : cmd le lit en page de code OEM.
rem
rem  LIRE      PROTOCOLE.md (section A) dit quoi chercher dans chaque section,
rem            src/installation/depannage.md du book donne les remedes.
rem ============================================================================

setlocal
echo.
echo Releve de l'etat du poste %COMPUTERNAME% pour le compte %USERNAME%.
echo Rien n'est modifie. Compter une a deux minutes.
echo.

rem ----------------------------------------------------------------------------
rem  Ou ecrire le rapport : a cote du script, sinon sur le Bureau, sinon dans
rem  le profil. Le premier emplacement qui accepte l'ecriture est retenu.
rem ----------------------------------------------------------------------------
set "NOM=diagnostic_%COMPUTERNAME%_%USERNAME%.txt"
set "RAPPORT=%~dp0%NOM%"
(echo.) > "%RAPPORT%" 2>nul && goto :rapport_pret
set "RAPPORT=%USERPROFILE%\Desktop\%NOM%"
(echo.) > "%RAPPORT%" 2>nul && goto :rapport_pret
set "RAPPORT=%USERPROFILE%\%NOM%"
(echo.) > "%RAPPORT%"
:rapport_pret
echo Rapport : %RAPPORT%

echo Releve du %DATE% %TIME% sur %COMPUTERNAME%, compte %USERNAME% >> "%RAPPORT%"
echo Legende : "present :" ou "absent  :" devant un chemin dit s'il existe. >> "%RAPPORT%"
echo Chaque section commence par "Ce qu'on regarde", puis les releves. >> "%RAPPORT%"


rem ============================================================================
call :titre "0. Reseau" "Une reponse qui commence par HTTP/ veut dire que le reseau passe. Pas de reponse en 10 secondes, ou 'Could not resolve host' : session reseau non ouverte, lancer le raccourci d'authentification. Code 407 ou erreur de certificat : un proxy est en jeu."
rem ============================================================================
call :sous_titre "curl.exe -sS -I -m 10 https://repo.anaconda.com"
curl.exe -sS -I -m 10 https://repo.anaconda.com >> "%RAPPORT%" 2>&1
call :sous_titre "curl.exe -sS -I -m 10 https://marketplace.visualstudio.com"
curl.exe -sS -I -m 10 https://marketplace.visualstudio.com >> "%RAPPORT%" 2>&1
call :sous_titre "proxy declare a Windows"
netsh winhttp show proxy >> "%RAPPORT%" 2>&1
call :sous_titre "variables HTTP_PROXY et HTTPS_PROXY du compte"
set HTTP >> "%RAPPORT%" 2>&1


rem ============================================================================
call :titre "1. Poste et session" "La version de Windows, et ou est range le profil. Un APPDATA qui commence par deux barres obliques inverses ou par une autre lettre que C: est un profil sur le reseau."
rem ============================================================================
ver >> "%RAPPORT%"
powershell -NoProfile -Command "$os = Get-CimInstance Win32_OperatingSystem; $os.Caption + ' ' + $os.Version" >> "%RAPPORT%" 2>&1
echo compte : %USERNAME%   domaine : %USERDOMAIN%   poste : %COMPUTERNAME% >> "%RAPPORT%"
echo USERPROFILE  = %USERPROFILE% >> "%RAPPORT%"
echo APPDATA      = %APPDATA% >> "%RAPPORT%"
echo LOCALAPPDATA = %LOCALAPPDATA% >> "%RAPPORT%"
echo PROGRAMDATA  = %PROGRAMDATA% >> "%RAPPORT%"


rem ============================================================================
call :titre "2. VS Code" "Ou il est installe, sa version, les extensions (ms-python.python, ms-python.vscode-python-envs, ms-toolsai.jupyter) et les reglages User deja poses (python.condaPath, terminal.integrated.defaultProfile.windows)."
rem ============================================================================
set "CODE="
call :chercher_code
call :sous_titre "where code"
where code >> "%RAPPORT%" 2>&1
echo code.cmd retenu : %CODE% >> "%RAPPORT%"
if not defined CODE echo VS Code introuvable aux emplacements usuels >> "%RAPPORT%"
if defined CODE call :versions_code
call :contenu "%APPDATA%\Code\User\settings.json"
call :sous_titre "dossiers de journaux VS Code, du plus recent au plus ancien"
dir /b /o-d "%APPDATA%\Code\logs" >> "%RAPPORT%" 2>&1


rem ============================================================================
call :titre "3. PowerShell" "La strategie d'execution. Restricted est attendu. Si MachinePolicy ou UserPolicy n'est pas Undefined, une strategie de groupe la fixe et Set-ExecutionPolicy ne servira a rien. Un profil contenant 'conda initialize' veut dire qu'un conda init powershell a ete fait."
rem ============================================================================
call :sous_titre "executables"
where powershell pwsh >> "%RAPPORT%" 2>&1
call :sous_titre "Windows PowerShell : version et strategie"
powershell -NoProfile -Command "$PSVersionTable.PSVersion.ToString(); Get-ExecutionPolicy -List | Format-Table -AutoSize | Out-String" >> "%RAPPORT%" 2>&1
where pwsh >nul 2>&1 && call :strategie_pwsh
call :sous_titre "cles de strategie de groupe PowerShell (une erreur 'unable to find' = pas de strategie)"
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell" >> "%RAPPORT%" 2>&1
reg query "HKCU\SOFTWARE\Policies\Microsoft\Windows\PowerShell" >> "%RAPPORT%" 2>&1
call :sous_titre "profils PowerShell du compte"
call :profil_ps "%USERPROFILE%\Documents\WindowsPowerShell\profile.ps1"
call :profil_ps "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
call :profil_ps "%USERPROFILE%\Documents\PowerShell\profile.ps1"
call :profil_ps "%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"


rem ============================================================================
call :titre "4. PATH, python et conda vus depuis un cmd ordinaire" "'where conda' vide = conda hors PATH, ce qui est le cas normal. 'where python' dit quel python repond en premier hors Anaconda Prompt : un alias du Store dans WindowsApps, un vieux C:\Python27, ou rien."
rem ============================================================================
call :sous_titre "PATH"
echo %PATH% >> "%RAPPORT%"
call :sous_titre "variables CONDA, JUPYTER, PYTHON"
set CONDA >> "%RAPPORT%" 2>&1
set JUPYTER >> "%RAPPORT%" 2>&1
set PYTHON >> "%RAPPORT%" 2>&1
call :sous_titre "where python, conda, jupyter, git"
where python >> "%RAPPORT%" 2>&1
where conda >> "%RAPPORT%" 2>&1
where jupyter >> "%RAPPORT%" 2>&1
where git >> "%RAPPORT%" 2>&1
call :sous_titre "alias du Microsoft Store"
dir /b "%LOCALAPPDATA%\Microsoft\WindowsApps\python*.exe" >> "%RAPPORT%" 2>&1


rem ============================================================================
call :titre "5. Anaconda : raccourcis, dossiers, fichiers de configuration" "La cible du raccourci Anaconda Prompt donne le chemin reel de l'installation, a recopier dans le profil de terminal de VS Code. environments.txt absent = aucun environnement encore connu pour ce compte."
rem ============================================================================
call :sous_titre "raccourcis du menu Demarrer (cible et arguments)"
powershell -NoProfile -Command "$sh = New-Object -ComObject WScript.Shell; Get-ChildItem -Recurse -Filter '*.lnk' -Path ($env:APPDATA + '\Microsoft\Windows\Start Menu\Programs'), ($env:PROGRAMDATA + '\Microsoft\Windows\Start Menu\Programs') -ErrorAction SilentlyContinue | Where-Object { $_.Name -match 'Anaconda|Navigator|Spyder|Jupyter' } | ForEach-Object { $l = $sh.CreateShortcut($_.FullName); $_.FullName; '   cible : ' + $l.TargetPath; '   args  : ' + $l.Arguments }" >> "%RAPPORT%" 2>&1
call :sous_titre "dossiers d'installation connus"
set "ANACONDA="
call :chercher_anaconda
echo installation retenue pour la suite : %ANACONDA% >> "%RAPPORT%"
call :sous_titre "dossier .conda du compte (environnements et cache crees sans droits)"
call :existe "%USERPROFILE%\.conda"
call :contenu "%USERPROFILE%\.conda\environments.txt"
call :contenu "%USERPROFILE%\.condarc"
if defined ANACONDA call :fichiers_anaconda


rem ============================================================================
call :titre "6. Registre : les Python inscrits" "D'ou vient un eventuel Python 2.7 ou un autre Python, et si Anaconda est inscrit (ContinuumAnalytics)."
rem ============================================================================
reg query "HKLM\SOFTWARE\Python" /s >> "%RAPPORT%" 2>&1
reg query "HKLM\SOFTWARE\WOW6432Node\Python" /s >> "%RAPPORT%" 2>&1
reg query "HKCU\SOFTWARE\Python" /s >> "%RAPPORT%" 2>&1
call :existe "C:\Python27"


rem ============================================================================
call :titre "7. conda, une fois active : version, info, environnements" "'envs directories' doit citer un dossier du profil, en plus de celui de l'installation. 'conda env list' est la reference a comparer avec ce que VS Code propose. ipykernel doit etre dans base. 'conda tos' dit si les conditions d'utilisation sont acceptees."
rem ============================================================================
if not defined ANACONDA echo aucune installation conda trouvee, section sautee >> "%RAPPORT%"
if defined ANACONDA call :releve_conda


rem ============================================================================
call :titre "8. Noyaux Jupyter presents sur le disque" "Les noyaux declares pour le compte et ceux livres avec l'installation. VS Code n'en a pas besoin pour un environnement conda, Navigator et JupyterLab si."
rem ============================================================================
call :liste_dossier "%APPDATA%\jupyter\kernels"
call :liste_dossier "%PROGRAMDATA%\jupyter\kernels"
if defined ANACONDA call :liste_dossier "%ANACONDA%\share\jupyter\kernels"


rem ============================================================================
call :titre "9. Derniers journaux de VS Code : Python, Python Environments, Jupyter" "Chercher les lignes 'Probing conda binary', 'Conda not found', 'running scripts is disabled', 'ipykernel_launcher'."
rem ============================================================================
set "LOGDIR="
for /f "delims=" %%d in ('dir /b /o-d "%APPDATA%\Code\logs" 2^>nul') do if not defined LOGDIR set "LOGDIR=%APPDATA%\Code\logs\%%d"
if not defined LOGDIR echo aucun journal VS Code >> "%RAPPORT%"
if defined LOGDIR call :journaux_code


rem ============================================================================
call :titre "10. Anaconda Navigator" "Un processus pythonw.exe present alors qu'aucune fenetre Navigator n'est ouverte est une instance bloquee, a terminer dans le Gestionnaire des taches. Le fichier navigator.lock ne gene que si ce processus existe. Le journal dit sur quoi Navigator attendait."
rem ============================================================================
call :sous_titre "processus pythonw.exe en cours (Navigator tourne dans pythonw.exe)"
tasklist /v /fi "imagename eq pythonw.exe" >> "%RAPPORT%" 2>&1
call :sous_titre "fichiers de Navigator dans le profil"
dir /s /b "%USERPROFILE%\.anaconda" >> "%RAPPORT%" 2>&1
dir /s /b "%APPDATA%\.anaconda" >> "%RAPPORT%" 2>&1
call :sous_titre "fin du journal navigator.log"
for /r "%USERPROFILE%\.anaconda" %%f in (navigator*.log) do call :fin_de_fichier "%%f"
for /r "%APPDATA%\.anaconda" %%f in (navigator*.log) do call :fin_de_fichier "%%f"


echo.
echo Termine. Rapport : %RAPPORT%
echo A rapporter tel quel (cle USB, mail).
pause
exit /b 0


rem ============================================================================
rem  Sous-programmes. Chacun ecrit dans le rapport et ne modifie rien.
rem ============================================================================

rem --- titre "n. Titre" "ce qu'on regarde" : entete de section, a l'ecran et
rem     dans le rapport --------------------------------------------------------
:titre
echo [%~1]
echo. >> "%RAPPORT%"
echo ====================================================================== >> "%RAPPORT%"
echo %~1 >> "%RAPPORT%"
echo ====================================================================== >> "%RAPPORT%"
if not "%~2"=="" echo Ce qu'on regarde : %~2 >> "%RAPPORT%"
echo. >> "%RAPPORT%"
goto :eof

rem --- sous_titre "texte" : separateur entre deux releves d'une section ------
:sous_titre
echo. >> "%RAPPORT%"
echo --- %~1 --- >> "%RAPPORT%"
goto :eof

rem --- existe "chemin" : une ligne present/absent -----------------------------
:existe
if exist "%~1" echo present : %~1 >> "%RAPPORT%"
if not exist "%~1" echo absent  : %~1 >> "%RAPPORT%"
goto :eof

rem --- contenu "fichier" : le contenu du fichier, ou absent -------------------
:contenu
call :sous_titre "contenu de %~1"
if exist "%~1" type "%~1" >> "%RAPPORT%" 2>&1
if not exist "%~1" echo absent >> "%RAPPORT%"
goto :eof

rem --- liste_dossier "dossier" : les entrees du dossier, ou absent ------------
:liste_dossier
call :sous_titre "%~1"
if exist "%~1" dir /b "%~1" >> "%RAPPORT%" 2>&1
if not exist "%~1" echo absent >> "%RAPPORT%"
goto :eof

rem --- fin_de_fichier "fichier" : ses 100 dernieres lignes --------------------
:fin_de_fichier
echo. >> "%RAPPORT%"
echo --- %~1, 100 dernieres lignes --- >> "%RAPPORT%"
powershell -NoProfile -Command "Get-Content -Tail 100 -LiteralPath '%~1'" >> "%RAPPORT%" 2>&1
goto :eof

rem --- profil_ps "fichier" : present ou absent, et s'il contient conda init ---
:profil_ps
call :existe "%~1"
if exist "%~1" findstr /C:"conda initialize" "%~1" >> "%RAPPORT%" 2>&1
goto :eof

rem --- chercher_code : note chaque emplacement usuel de code.cmd et retient
rem     le premier qui existe dans CODE ----------------------------------------
:chercher_code
for %%p in (
  "%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd"
  "%ProgramFiles%\Microsoft VS Code\bin\code.cmd"
  "%ProgramFiles(x86)%\Microsoft VS Code\bin\code.cmd"
) do (
  call :existe "%%~p"
  if not defined CODE if exist "%%~p" set "CODE=%%~p"
)
goto :eof

rem --- versions_code : version de VS Code et liste des extensions -------------
:versions_code
call :sous_titre "code --version"
call "%CODE%" --version >> "%RAPPORT%" 2>&1
call :sous_titre "extensions installees"
call "%CODE%" --list-extensions --show-versions >> "%RAPPORT%" 2>&1
goto :eof

rem --- strategie_pwsh : meme releve pour PowerShell 7 quand il est la --------
:strategie_pwsh
call :sous_titre "PowerShell 7 (pwsh) : version et strategie"
pwsh -NoProfile -Command "$PSVersionTable.PSVersion.ToString(); Get-ExecutionPolicy -List | Format-Table -AutoSize | Out-String" >> "%RAPPORT%" 2>&1
goto :eof

rem --- chercher_anaconda : note chaque emplacement usuel et retient le
rem     premier qui contient Scripts\conda.exe dans ANACONDA -------------------
:chercher_anaconda
for %%d in (
  "%PROGRAMDATA%\anaconda3"
  "%PROGRAMDATA%\miniconda3"
  "%USERPROFILE%\anaconda3"
  "%USERPROFILE%\miniconda3"
  "%LOCALAPPDATA%\anaconda3"
  "%LOCALAPPDATA%\Continuum\anaconda3"
  "C:\anaconda3"
) do (
  call :existe "%%~d"
  if not defined ANACONDA if exist "%%~d\Scripts\conda.exe" set "ANACONDA=%%~d"
)
goto :eof

rem --- fichiers_anaconda : .condarc de l'installation et scripts d'activation -
:fichiers_anaconda
call :contenu "%ANACONDA%\.condarc"
call :sous_titre "scripts d'activation"
call :existe "%ANACONDA%\Scripts\activate.bat"
call :existe "%ANACONDA%\condabin\conda.bat"
call :existe "%ANACONDA%\shell\condabin\conda-hook.ps1"
goto :eof

rem --- releve_conda : active l'installation dans ce cmd (comme le fait le
rem     raccourci Anaconda Prompt) puis interroge conda, python, jupyter -------
:releve_conda
echo activation par %ANACONDA%\Scripts\activate.bat >> "%RAPPORT%"
call "%ANACONDA%\Scripts\activate.bat" "%ANACONDA%"
call :sous_titre "conda --version"
conda --version >> "%RAPPORT%" 2>&1
call :sous_titre "conda info"
conda info >> "%RAPPORT%" 2>&1
call :sous_titre "conda env list"
conda env list >> "%RAPPORT%" 2>&1
call :sous_titre "ipykernel dans base"
conda list -n base "^ipykernel$" >> "%RAPPORT%" 2>&1
call :sous_titre "conditions d'utilisation des canaux (conda tos)"
conda tos >> "%RAPPORT%" 2>&1
call :sous_titre "python : executable, prefixe, version"
python -c "import sys; print(sys.executable); print(sys.prefix); print(sys.version)" >> "%RAPPORT%" 2>&1
call :sous_titre "noyaux vus par jupyter"
jupyter kernelspec list >> "%RAPPORT%" 2>&1
call :sous_titre "variables CONDA et JUPYTER apres activation"
set CONDA >> "%RAPPORT%" 2>&1
set JUPYTER >> "%RAPPORT%" 2>&1
goto :eof

rem --- journaux_code : fin des journaux des trois extensions ------------------
:journaux_code
echo dossier : %LOGDIR% >> "%RAPPORT%"
rem     (avec un joker : sans joker, for /r cite le nom dans chaque dossier
rem     meme s'il n'existe pas)
for /r "%LOGDIR%" %%f in (Python*.log Jupyter*.log) do call :fin_de_fichier "%%f"
goto :eof
