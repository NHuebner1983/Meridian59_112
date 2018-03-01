echo off

echo Set next line of this script to your Disk containing your M59 folder.

	D:

echo Set next line of this script to your M59 folder.

	cd Meridian59

echo Set next line of this script to the vcvarsall.bat. If you cannot find this file, it usually comes with Visual Studio 2015.

	call "D:\Visual Studio 2015\VC\vcvarsall.bat" x86

echo "This command should build blakserv and perform all of the heavy lifting such as KOD updates."

	nmake debug=1

echo ----------------------------
echo All finished!
echo ----------------------------
echo on

	pause

