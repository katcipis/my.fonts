#/bin/bash

echo "Copying fonts"
if [ ! -e ~/.fonts/Monaco.ttf ]; then
    mkdir -p ~/.fonts
    echo "copying Monaco font"
    cp -rf fonts/Monaco.ttf ~/.fonts/Monaco.ttf
fi

if [ ! -e ~/.fonts/PowerlineSymbols.otf ]; then
    mkdir -p ~/.fonts
    echo "copying PowerineSymbols"
    cp -rf fonts/PowerlineSymbols.otf ~/.fonts/PowerlineSymbols.otf
fi

if [ ! -e ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ]; then
    echo "copying poweline symbols config"
    mkdir -p ~/.config/fontconfig/conf.d
    cp -rf fonts/10-powerline-symbols.conf ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
fi

# build font information cache files
echo "Build font information cache files ..."
fc-cache -f ~/.fonts > /dev/null 2>&1

echo
echo "Done, restart your X Server"
