#!/bin/bash

# Determine the script's directory
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "For preventing canvas fingerprinting, you can use browser extensions like CanvasBlocker."

# Check if ProtonVPN is installed
if command -v protonvpn &> /dev/null; then
    # Switch IP
    protonvpn c -r
else
    echo "ProtonVPN is not installed."
fi

# Check if Mozilla directory exists
if [ -d ~/.mozilla/firefox/*.default ]; then
    # Clear cookies
    sqlite3 ~/.mozilla/firefox/*.default/cookies.sqlite "DELETE FROM moz_cookies"

    # Change user agent
    echo 'user_pref("general.useragent.override", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3");' >> ~/.mozilla/firefox/*.default/prefs.js
else
    echo "Mozilla ~/.mozilla/firefox/ directory not found."
fi

# Check if Chrome directory exists
if [ -d ~/.config/google-chrome/Default ]; then
    # Clear cookies
    rm ~/.config/google-chrome/Default/Cookies

    # Change user agent
    echo 'chrome://flags/#user-agent' >> ~/.config/google-chrome/Default/Preferences
else
    echo "Chrome ~/.config/google-chrome/ directory not found."
fi
