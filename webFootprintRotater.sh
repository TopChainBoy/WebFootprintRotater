#!/bin/bash

# Determine the script's directory
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "For preventing canvas fingerprinting, you can use browser extensions like CanvasBlocker."

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to check if a directory exists
directory_exists() {
    [ -d "$1" ]
}

# Check if ProtonVPN is installed
if command_exists protonvpn; then
    # Switch IP
    protonvpn c -r
else
    echo "ProtonVPN is not installed."
fi

# Check if Mozilla directory exists
MOZILLA_DIR=$(find ~/.mozilla/firefox/*.default -maxdepth 0 -type d 2>/dev/null)
if directory_exists "$MOZILLA_DIR"; then
    # Clear cookies
    sqlite3 "$MOZILLA_DIR/cookies.sqlite" "DELETE FROM moz_cookies"

    # Change user agent
    echo 'user_pref("general.useragent.override", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3");' >> "$MOZILLA_DIR/prefs.js"
else
    echo "Mozilla ~/.mozilla/firefox/ directory not found."
fi

# Check if Chrome directory exists
CHROME_DIR=~/.config/google-chrome/Default
if directory_exists "$CHROME_DIR"; then
    # Clear cookies
    rm "$CHROME_DIR/Cookies"

    # Change user agent
    echo 'chrome://flags/#user-agent' >> "$CHROME_DIR/Preferences"
else
    echo "Chrome ~/.config/google-chrome/ directory not found."
fi
