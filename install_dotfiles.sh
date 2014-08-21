#/bin/bash

REPO=https://github.com/lborguetti/my.terminator
TMP_DIR=$(mktemp -d)

# create temp dir
echo "Create tmp dir"
mkdir -p ${TMP_DIR}
cd ${TMP_DIR}

# clone repo with dotfiles
echo "Clone ${REPO} ..."
git clone ${REPO}

# cp dotfiles to home dir
echo "Copy dotfiles ..."
cd my.fonts
if [ -e ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ]; then
    mv -rf ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ~/.config/fontconfig/conf.d/10-powerline-symbols.bkp
    mkdir ~/.config/fontconfig/conf.d
    cp -rf config/fontconfig/conf.d/10-powerline-symbols.conf ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
else
    mkdir -p ~/.config/fontconfig/conf.d
    cp -rf config/fontconfig/conf.d/10-powerline-symbols.conf ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
fi

if [ ! -e ~/.fonts/Monaco.ttf ]; then
    mkdir -p ~/.fonts
    cp -rf fonts/Monaco.ttf ~/.fonts/Monaco.ttf
fi

if [ ! -e ~/.fonts/PowerlineSymbols.otf ]; then
    mkdir -p ~/.fonts
    cp -rf fonts/PowerlineSymbols.otf ~/.fonts/PowerlineSymbols.otf
fi

cd ~

# clean tmp files
echo "Clean tmp dir ..."
rm -rf ${TMP_DIR}

# build font information cache files
echo "Build font information cache files ..."
fc-cache -f ~/.fonts > /dev/null 2>&1

echo
echo "Done, restart your X Server"
