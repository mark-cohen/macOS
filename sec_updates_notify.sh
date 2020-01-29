#!/bin/bash

# move to working directory
cd ~/Documents/Security_Updates/

# write changes to temp file
f=$PWD/Changes/Latest_Changes.txt

# get the current catalog from Apple, save to "sucatalog_latest"
curl -sL https://swscan.apple.com/content/catalogs/others/index-10.15-10.14-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog -o sucatalog_latest

# detect differences
diff sucatalog sucatalog_latest > diff.txt

# are there new items posted to the catalaog, marked with the "PostDate" key?
grep -q PostDate diff.txt

# if [ $? -eq 0 ];
# then

# regex to search in the diff
mrt="http.+MRTConfigData.+pkg"
xpr="http.+XProtect.+pkg"
gkp="http.+Gatekeeper.+Data.pkg"
kxt="http.+AppleKextExcludeList.+pkg"

d=$(egrep "$mrt|$xpr|$gkp|$kxt" diff.txt)

# extract the URL's we're interested in, and write them to a file
if [ $? -eq 0 ];
    then
        for i in $d;
        do
        if [[ $i =~ ".pkg" ]]
            then
            # optional notification via dialogue, better to use a folder action
            # osascript -e "display dialog \"New Software Updates Are Available\" with title \"Heads Up!\" buttons \"OK\" default button \"OK\""

            url=$(echo $i | awk '{print $1}' | sed 's/^<string>//' | sed 's/\.pkg.*/.pkg/')
            echo $url;
            echo "$(date)" >> "$f"
            echo $url >> "$f"
            fi
        done;
    fi

#clean up
rm -f diff.txt sucatalog
mv sucatalog_latest sucatalog

