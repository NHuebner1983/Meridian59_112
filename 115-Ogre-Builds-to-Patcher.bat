echo off


REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM % Configure your Development Meridian 59 Drive, Directory and OgreClient Bin %
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	SET "M59_DRIVE=D"
	SET "M59_FOLDER=Meridian59"
    SET "M59_FULL_PATH=%M59_DRIVE%:\%M59_FOLDER%"

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM %                   Optional M59 OgreClient Bin (KODers)                     %
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	SET "M59_OGRE_BASE=%M59_FULL_PATH%\_OgreClient"
	SET "M59_OGRE_BIN=%M59_OGRE_BASE%\Meridian59.Ogre.Client\bin"
	SET "M59_OGRE_PATCHER_BIN=%M59_OGRE_BASE%\Meridian59.Patcher\bin\x86\Release"
	SET "M59_OGRE_SETUP_BIN=%M59_OGRE_BASE%\Meridian59.Ogre.Setup\Release"

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM %                   Patcher Folder (To Upload or Commit                      %
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	SET "M59_PATCH_FOLDER=%M59_FULL_PATH%\_Server115"
	SET "OGRE_PATCH_FOLDER=%M59_PATCH_FOLDER%\ogrepatch"
	SET "OGRE_SETUP_FOLDER=%M59_PATCH_FOLDER%\download"
	
REM ###########################################################################
REM #         You shouldn't have to touch anything below this line            #
REM ###########################################################################



SET "EDIT_VERBIAGE=Edit this script and try again."

IF NOT EXIST "%M59_DRIVE%": (
	ECHO The drive %M59_DRIVE%:\ does not exist. %EDIT_VERBIAGE%
	pause
	exit
)
IF NOT EXIST "%M59_FULL_PATH%" (
	ECHO The folder %M59_FULL_PATH% does not exist. %EDIT_VERBIAGE%
	pause
	exit
)
IF NOT EXIST "%M59_OGRE_BIN%" (
	ECHO The folder %M59_OGRE_BIN% does not exist. %EDIT_VERBIAGE%
	pause
	exit
)
IF NOT EXIST "%OGRE_PATCH_FOLDER%" (
	ECHO The folder %OGRE_PATCH_FOLDER% does not exist. %EDIT_VERBIAGE%
	pause
	exit
)

echo Your directories are setup correctly.

	IF EXIST "%M59_OGRE_BIN%" (
		IF EXIST "%M59_OGRE_BIN%\x86\Release" (
			echo Copying: %M59_OGRE_BIN%\x86\Release\...
			copy /Y "%M59_OGRE_BIN%\x86\Release\*" "%OGRE_PATCH_FOLDER%\x86\"
		)
		IF EXIST "%M59_OGRE_BIN%\x64\Release" (
			echo Copying: %M59_OGRE_BIN%\x64\Release\...
			copy /Y "%M59_OGRE_BIN%\x64\Release\*" "%OGRE_PATCH_FOLDER%\x64\"
		)
	)
	IF EXIST "%M59_OGRE_PATCHER_BIN%" (
		echo Copying: %M59_OGRE_PATCHER_BIN%\...
		copy /Y "%M59_OGRE_PATCHER_BIN%\*.exe" "%OGRE_PATCH_FOLDER%\"
	)
	IF EXIST "%M59_OGRE_SETUP_BIN%" (
		echo Copying: %M59_OGRE_SETUP_BIN%\...
		copy /Y "%M59_OGRE_SETUP_BIN%\*.exe" "%OGRE_SETUP_FOLDER%\"
	)

	pause

