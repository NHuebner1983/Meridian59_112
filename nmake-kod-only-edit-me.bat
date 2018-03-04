echo off

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM %        Configure your current Visual Studio vcvarsall.bat location         %
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	SET "VISUAL_STUDIO_DRIVE=D"

	SET "VCVBAT=%VISUAL_STUDIO_DRIVE%:\Visual Studio 2015\VC\vcvarsall.bat"

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM % Configure your Development Meridian 59 Drive, Directory and OgreClient Bin %
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	SET "M59_DRIVE=D"

	SET "M59_FOLDER=Meridian59"

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM %                   Optional M59 OgreClient Bin (KODers)                     %
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	SET "M59_OGRE_BIN=%M59_DRIVE%:\%M59_FOLDER%\_OgreClient\Meridian59.Ogre.Client\bin"




REM ###########################################################################
REM #         You shouldn't have to touch anything below this line            #
REM ###########################################################################





SET "EDIT_VERBIAGE=Edit this script and try again."

IF NOT EXIST "%VISUAL_STUDIO_DRIVE%:" (
	ECHO The Visual Studio drive %VISUAL_STUDIO_DRIVE% does not exist. %EDIT_VERBIAGE%
	pause
	exit
)
IF NOT EXIST "%VCVBAT%" (
	ECHO The Visual Studio file %VCVBAT% does not exist. %EDIT_VERBIAGE%
	pause
	exit
)
IF NOT EXIST "%M59_DRIVE%": (
	ECHO The drive %M59_DRIVE%:\ does not exist. %EDIT_VERBIAGE%
	pause
	exit
)
IF NOT EXIST "%M59_DRIVE%:\%M59_FOLDER%" (
	ECHO The folder %M59_DRIVE%:\%M59_FOLDER% does not exist. %EDIT_VERBIAGE%
	pause
	exit
)

IF NOT EXIST "%M59_OGRE_BIN%" (
	ECHO Notice: M59 Ogre Bin was not found. When you want your RSB strings updated to your client, be sure to update this path.
	pause
	exit
)

echo Your directories are setup correctly.
echo Starting the Visual Studio vcvarsall.bat script...
echo Please wait...

	%M59_DRIVE%:
	cd /
	cd %M59_FOLDER%
	cd kod
	call "%VCVBAT%" x86

echo Building your Meridian 59 Solution...
echo on

	nmake debug=1

echo off
echo The operation has completed.
echo If you're satisfied, press any key to close this window.


	IF EXIST "%M59_OGRE_BIN%" (
		IF EXIST "%M59_OGRE_BIN%\x86\resources\strings" (
			echo Destination: %M59_OGRE_BIN%\x86\resources\strings\
			copy /Y "%M59_DRIVE%:\%M59_FOLDER%\run\server\rsc\rsc*.rsb" "%M59_OGRE_BIN%\x86\resources\strings\"
		)
		IF EXIST "%M59_OGRE_BIN%\x64\resources\strings" (
			echo Destination: %M59_OGRE_BIN%\x64\resources\strings\
			copy /Y "%M59_DRIVE%:\%M59_FOLDER%\run\server\rsc\rsc*.rsb" "%M59_OGRE_BIN%\x64\resources\strings\"
		)
	)

	pause

