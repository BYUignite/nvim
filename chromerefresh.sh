#!/bin/sh

# DOL; found this online. Using with reveal.js for ChEn 433 lecture notes.
# http://loopduplicate.com/content/refresh-chrome-from-the-mac-terminal-using-applescript
# See also init.vim markdown area remap leader v to save, compile code and refresh chrome (here)

#exec <"$0" || exit; read v; read v; exec /usr/bin/osascript - "$@"; exit
# The line above allows the rest of the file to be written in plain AppleScript.
 
osascript<<EOF
tell application "Google Chrome"
  activate
  tell application "System Events"
    tell process "Google Chrome"
      keystroke "r" using {command down, shift down}
    end tell
  end tell
end tell
 
tell application "iTerm2" to activate
EOF
