#!/bin/bash
# A simple menu system
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
white=$'\e[0m'
reset="tput sgr0"
names='poc retail mym QUIT-Select-this-to-quit runScript chromeDebug'

PS3=$grn'Select character: '
$reset

select name in $names; do
    $reset
    if [ "$name" == 'QUIT-Select-this-to-quit' ]; then
        break
    fi

    if [ -d "$name" ]; then
        cd "$name"
        echo "${mag}You are now in $name directory."
        echo "Listing subdirectories..."
        subdirs=$(find . -maxdepth 1 -type d | sed 's|^\./||' | tail -n +2) # List subdirectories
        subdirs="$subdirs go-back"

        PS3=$grn'Select subdirectory: '
        select subdir in $subdirs; do
            if [ "$subdir" == 'go-back' ]; then
                break
            elif [ -d "$subdir" ]; then
                cd "$subdir"
                echo "${mag}You are now in $subdir directory."
                echo "Do you want to:"
                echo "1. Build"
                echo "2. Build and Deploy"
                read -p "Enter your choice (1 or 2): " choice
                if [ "$choice" == "1" ]; then
                    echo "${mag}Performing Maven build..."
                    mvn clean install
                elif [ "$choice" == "2" ]; then
                    if [ "$subdir" == "web-service-oms-cms" ]; then
                        echo "${mag}Performing Maven build and deploy for web-service-oms-cms..."
                        mvn clean install -P auto-deploy -DskipTests=true
                    else
                        echo "${mag}Performing Maven build and deploy..."
                        mvn clean install -PautoInstallPackage -DskipTests=true
                    fi
                else
                    echo "${red}Invalid choice. Skipping..."
                fi
                cd ..
            else
                echo "${red}Invalid selection. Try again."
            fi
        done
        cd ..
    else
        echo "${red}Invalid selection or directory does not exist."
    fi

    if [ "$name" == 'runScript' ]; then
        ls
        echo $red"Type Script below to run ..."
        read varname
        $varname
    fi

    if [ "$name" == 'chromeDebug' ]; then
        echo 'Starting Chrome in Debug Mode with Port 9222'
        "C:/Program Files/Google/Chrome/Application/chrome.exe" --remote-debugging-port=9222 &
    fi

    $reset
done
echo $red' Qutting...'
echo ' '
$reset