#!/bin/bash

curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fish -c "fisher add jethrokuan/z"
fish -c "fisher add oh-my-fish/plugin-peco"
fish -c "fisher add oh-my-fish/theme-bobthefish"