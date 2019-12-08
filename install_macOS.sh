#!/bin/sh

### define installer behavior
StartInstall ()
{
### install mojave ### 
    /Applications/Install\ macOS\ Mojave.app/Contents/Resources/startosinstall \
    --rebootdelay 5 \
    --nointeraction \
    --agreetolicense
    exit 0
}

OS=$(sw_vers -productVersion | cut -c 1-5)

### if already up to date, abort ### 
if [ "$OS" = "10.14" ]; 
then
    echo "10.14 already installed"
    exit 0
fi

### if less than 10GB of free space, abort ### 
StorageAvail=$(df -H / | tail -1 | awk '{print $4}' | tr -d "G")

if [ $StorageAvail -lt 10 ]; 
then
    echo "Not enough free space"
    exit 0
fi

### if installer isnt present, abort ### 
if [ ! -d "/Applications/Install macOS Mojave.app" ];
then
    echo "macOS installer not present"
    exit 0
fi

PluggedInYN=$(pmset -g ps | grep "Power" | cut -c 18- | tr -d "'")

### are we plugged in? ### 
if [ "$PluggedInYN" = "AC Power" ]; 
then
    echo "not on battery power, proceeding"
    StartInstall

else
### do we have enough power? ### 
    BatteryPercentage=$(pmset -g ps | tail -1 | awk -F ";" '{print $1}' | awk -F "\t" '{print $2}' | tr -d "%")
    if [ $BatteryPercentage -ge 75 ]; 
    then
    echo "battery at 75% or higher, proceeding"    
    StartInstall

    else
        echo "battery less than 75%, aborting"
        exit 0
    fi
fi