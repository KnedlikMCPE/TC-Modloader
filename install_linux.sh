./godotpcktool "../Turing Complete.pck" -a e -o extracted
rm "extracted\main_scripts\init.gdc"
rm "extracted\main_scripts\init.gd.remap"
cp "init.gd" "extracted/main_scripts/" /y
./godotpcktool "Turing Complete.pck" -a a extracted --remove-prefix extracted
rm -r extracted
cp "Turing Complete.pck" "../" /y
rm "Turing Complete.pck"
cp "TCModLoader.pck" "../"