godotpcktool "../Turing Complete.pck" -a e -o extracted
del /f "extracted\main_scripts\init.gdc"
del /f "extracted\main_scripts\init.gd.remap"
xcopy "init.gd" "extracted/main_scripts/" /y
godotpcktool "Turing Complete.pck" -a a extracted --remove-prefix extracted
rmdir /S /Q extracted
xcopy "Turing Complete.pck" "../" /y
del "Turing Complete.pck"
pause