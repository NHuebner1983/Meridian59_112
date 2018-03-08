echo off

REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
REM %                     Your Meridian 59 Server Number                         %
REM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	REM :::   Include the dash in front of the number   :::
	REM ::: or your RSB file will be called rsb0000.rsb :::
	
	SET "SERVER_NUMBER=-115"
	
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

	SET "M59_OGRE_BASE=%M59_DRIVE%:\%M59_FOLDER%\_OgreClient"
	SET "M59_OGRE_BIN=%M59_OGRE_BASE%\Meridian59.Ogre.Client\bin"
	SET "M59_OGRE_RESOURCES=%M59_OGRE_BASE%\Resources"




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
)

IF NOT EXIST "%M59_OGRE_RESOURCES%" (
	ECHO Notice: M59 Ogre Resources was not found. When you want your RSB strings to load when debugging in Visual Studio, you might want to fix this.
)

echo Your directories are setup correctly.
echo Starting the Visual Studio vcvarsall.bat script...
echo Please wait...

	%M59_DRIVE%:
	cd /
	cd %M59_FOLDER%
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
			copy /Y "%M59_DRIVE%:\%M59_FOLDER%\run\server\rsc\rsc0000.rsb" "%M59_OGRE_BIN%\x86\resources\strings\rsc0000%SERVER_NUMBER%.rsb"
		)
		IF EXIST "%M59_OGRE_BIN%\x64\resources\strings" (
			echo Destination: %M59_OGRE_BIN%\x64\resources\strings\
			copy /Y "%M59_DRIVE%:\%M59_FOLDER%\run\server\rsc\rsc0000.rsb" "%M59_OGRE_BIN%\x64\resources\strings\rsc0000%SERVER_NUMBER%.rsb"
		)
	)

	IF EXIST "%M59_OGRE_RESOURCES%" (
		IF EXIST "%M59_OGRE_RESOURCES%\strings" (
			echo Destination: %M59_OGRE_RESOURCES%\strings\
			copy /Y "%M59_DRIVE%:\%M59_FOLDER%\run\server\rsc\rsc0000.rsb" "%M59_OGRE_RESOURCES%\strings\rsc0000%SERVER_NUMBER%.rsb"
		)
	)

	pause

