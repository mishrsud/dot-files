#!/bin/bash

if hash tmux 2>/dev/null; then
    echo 'Moving .tmux.conf to home directory....'
    cp .tmux.conf ~/.tmux.conf
    echo 'Successfully moved .tmux.conf to home directory....'

    echo -e "\n"

    echo "Press any key to continue..."
    read
else
    echo "Please install tmux to run this script."
fi
