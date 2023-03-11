@echo off
chcp 28591 > nul

REM Script cr�e par Wizurth
REM Avant utilisation, veuillez v�rifier et modifier si-besoin 3 valeurs : path_valorant, path_shortcut et picture_name !

REM La variable path_valorant est l'emplacement de votre dossier Riot Games, il faut la changer en fonciton de votre installation.
REM La variable path_shortcut est l'emplacement du raccourci Valorant, veuillez le changer pour l'adapter � votre ordinateur.
REM La variable picture_name est le nom du fond valorant, il change � chaque saison et m�me pendant.
REM Pour v�rifier le nouveau nom c'est �l'emplacement suivant : \VALORANT\live\ShooterGame\Content\Movies\Menu\

REM Pour info %USERPROFILE% = C:\Users\VotreCompte\
REM Emplacement par d�faut de VALORANT : C:\Riot Games\VALORANT
REM -------DEBUT---------

set picture_name="HomePage_Gekko.mp4"
set path_valorant="C:\Jeux\Riot Games"
set patch_shortcut="%USERPROFILE%\Desktop\VALORANT.lnk"
set path_movie=%path_valorant%\Background" Switcher"


IF EXIST %path_movie%\%picture_name% (
	echo Dossier de travail trouv�, V�rification de l'�xistance d'un fond custom pour VALORANT dans le dossier de travail....
) ELSE (
	echo Dossier de travail introuvable. Cr�ation de celui-ci en cours....
	mkdir %path_movie%
	mkdir %path_movie%\custom
	mkdir %path_movie%\download
      mkdir %path_movie%\stock
	robocopy %path_valorant%\VALORANT\live\ShooterGame\Content\Movies\Menu\ %path_movie%\ %picture_name% /is /it /NFL /NDL /NJH /NJS /nc /ns /np

	IF EXIST %path_movie%\%picture_name% (
		echo Cr�ation du dossier de travail termin�e.
		echo Son emplacement est : %path_movie%\
		echo V�rification de l'�xistance votre nouveau fond VALORANT dans le dossier de travail....
	) ELSE (
	echo Cr�ation du dossier de travail �chou�e, fermeture du script.
	exit
	)
)

IF EXIST %path_movie%\custom\%picture_name% (
		echo Fond custom trouv� dans le dossier de travail, D�marrage de VALORANT avec le nouveau fond....
		echo.
	) ELSE (
		ren %path_movie%\custom\* %picture_name%
)
IF NOT EXIST %path_movie%\custom\%picture_name% (
		echo Un dossier s'est ouvert, copier votre vid�o custom dedans, ATTENTION un seul fichier doit s'y trouver sinon une erreur apparaitra.
		start C:\Windows\explorer.exe %path_movie%\download\
		echo Une fois fait, appuyez sur une touche.
		pause >nul
		xcopy /r /y /i %path_movie%\download\* %path_movie%\custom
		ren %path_movie%\custom\* %picture_name%
		del /q %path_movie%\download\*
			
		echo Fichier modifi� avec succ�s. D�marrage de VALORANT avec le nouveau fond....
		echo.	
)

echo Copie du fond original vers VALORANT...
robocopy %path_movie%\ %path_valorant%\VALORANT\live\ShooterGame\Content\Movies\Menu\ %picture_name% /is /it /NFL /NDL /NJH /NJS /nc /ns /np
echo Succ�s.
echo.

echo Lancement de VALORANT...
start "Riot Client" %patch_shortcut% /--launch-product=valorant /--launch-patchline=live
echo NE PAS TOUCHER, Attente du lancement du Client Riot.
timeout 8
start "Riot Client" %patch_shortcut% /--launch-product=valorant /--launch-patchline=live
echo NE PAS TOUCHER, Attente du lancement de VALORANT pour modification.
timeout 4

echo Copie du nouveau fond vers VALORANT...
robocopy %path_movie%\custom %path_valorant%\VALORANT\live\ShooterGame\Content\Movies\Menu\  %picture_name% /is /it /NFL /NDL /NJH /NJS /nc /ns /np

echo Patch r�ussi.