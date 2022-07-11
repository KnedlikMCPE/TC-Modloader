godotpcktool "../Turing Complete.pck" -a e -o extracted
del "extracted/main_scripts/init.gdc"
del "extracted/main_scripts/init.gd.remap"
xcopy init.gd extracted/main_scripts/
godotpcktool "Turing Complete.pck" -a a extracted --remove-prefix extracted
rmdir /S /Q extracted
xcopy "Turing Complete.pck" "../" /y
del "Turing Complete.pck"
pause