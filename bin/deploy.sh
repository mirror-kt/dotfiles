#!/bin/bash

DOT_DIRECTORY="${HOME}/dotfiles"
SPECIFY_FILES=""

git clone https://github.com/mirror-kt/dotfiles ${DOT_DIRECTORY}
cd ${DOT_DIRECTORY}

# deploy
echo "start deplying..."
for f in .??* ${SPECIFY_FILES}
do
    [[ ${f} == ".git" ]] && continue
    [[ ${f} == ".gitignore" ]] && continue
    [[ ${f} == ".DS_Store" ]] && continue

    ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done
echo "complete!"