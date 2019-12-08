#!/bin/bash

# auto-install security updates, do not auto-install macOS updates
/usr/bin/defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool false
/usr/bin/defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticallyInstallMacOSUpdates -bool false
/usr/bin/defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool true
/usr/bin/defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool true
/usr/bin/defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist CriticalUpdateInstall -bool true
/usr/bin/defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist ConfigDataInstall -bool true
/usr/bin/defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist EvaluateCriticalEvenIfUnchanged -bool true

# ignore (hide) macOS 10.15
/usr/sbin/softwareupdate --ignore "macOS Catalina"

exit