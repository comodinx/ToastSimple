#!/bin/bash

# Logger

ehelp() {
    echo -e "\033[1;37m$(tput sgr 0 1)$(tput bold)Usage$(tput sgr0):\033[0m $1"
}

edebug() {
    echo -e "\033[1;32m$1\033[0m"
}

ewarn() {
    echo -e "\033[0;33m$1\033[0m"
}

eerror() {
    echo -e "\033[0;33m✖ $1\033[0m"
}

getpodfile() {
    echo $(ls -l | egrep *.podspec | head -n1 | tr " " "\n" | tail -n1 | tr -d " ")
}
