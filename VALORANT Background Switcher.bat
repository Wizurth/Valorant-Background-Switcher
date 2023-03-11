@echo off
chcp 28591 > nul

REM Script crée par Wizurth 
REM Avant utilisation, veuillez vérifier et modifier si-besoin 3 valeurs : path_valorant, path_shortcut et picture_name !

REM La variable path_valorant est l'emplacement de votre dossier Riot Games, il faut la changer en fonciton de votre installation.
REM La variable path_shortcut est l'emplacement du raccourci Valorant, veuillez le changer pour l'adapter à votre ordinateur.
REM La variable picture_name est le nom du fond valorant, il change à chaque saison et même pendant.
REM Pour vérifier le nouveau nom c'est à l'emplacement suivant : \VALORANT\live\ShooterGame\Content\Movies\Menu\

REM -------DEBUT---------

set picture_name="HomePage_Gekko.mp4"
set path_valorant="C:\Riot Games"
set path_shortcut="%USERPROFILE%\Desktop\VALORANT.lnk"
set path_movie=%path_valorant%\Background" Switcher"


IF EXIST %path_movie%\%picture_name% (
	echo Dossier de travail trouvé, Vérification de l'éxistance d'un fond custom pour VALORANT dans le dossier de travail....
) ELSE (
	echo Dossier de travail introuvable. Création de celui-ci en cours....
	mkdir %path_movie%
	mkdir %path_movie%\custom
	mkdir %path_movie%\download
      mkdir %path_movie%\stock
	robocopy %path_valorant%\VALORANT\live\ShooterGame\Content\Movies\Menu\ %path_movie%\ %picture_name% /is /it /NFL /NDL /NJH /NJS /nc /ns /np

	IF EXIST %path_movie%\%picture_name% (
		echo Création du dossier de travail terminée.
		echo Son emplacement est : %path_movie%\
		echo Vérification de l'éxistance votre nouveau fond VALORANT dans le dossier de travail....
	) ELSE (
	echo Création du dossier de travail échouée, fermeture du script.
	exit
	)
)

IF EXIST %path_movie%\custom\%picture_name% (
		echo Fond custom trouvé dans le dossier de travail, Démarrage de VALORANT avec le nouveau fond....
		echo.
	) ELSE (
		ren %path_movie%\custom\* %picture_name%
)
IF NOT EXIST %path_movie%\custom\%picture_name% (
		echo Un dossier s'est ouvert, copier votre vidéo custom dedans, ATTENTION un seul fichier doit s'y trouver sinon une erreur apparaitra.
		start C:\Windows\explorer.exe %path_movie%\download\
		echo Une fois fait, appuyez sur une touche.
		pause >nul
		xcopy /r /y /i %path_movie%\download\* %path_movie%\custom
		ren %path_movie%\custom\* %picture_name%
		del /q %path_movie%\download\*
			
		echo Fichier modifié avec succés. Démarrage de VALORANT avec le nouveau fond....
		echo.	
)

echo Copie du fond original vers VALORANT...
robocopy %path_movie%\ %path_valorant%\VALORANT\live\ShooterGame\Content\Movies\Menu\ %picture_name% /is /it /NFL /NDL /NJH /NJS /nc /ns /np
echo Succés.
echo.

echo Lancement de VALORANT...
start "Riot Client" %path_shortcut% /--launch-product=valorant /--launch-patchline=live
echo NE PAS TOUCHER, Attente du lancement du Client Riot.
timeout 8
start "Riot Client" %path_shortcut% /--launch-product=valorant /--launch-patchline=live
echo NE PAS TOUCHER, Attente du lancement de VALORANT pour modification.
timeout 4

echo Copie du nouveau fond vers VALORANT...
robocopy %path_movie%\custom %path_valorant%\VALORANT\live\ShooterGame\Content\Movies\Menu\  %picture_name% /is /it /NFL /NDL /NJH /NJS /nc /ns /np

echo Patch réussi.
