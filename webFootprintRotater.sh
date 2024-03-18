#!/bin/bash

# Determine the script's directory
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Check if the special options are provided
CLEAR_CACHE=false
CLEAR_HISTORY=false
for arg in "$@"
do
    if [[ $arg == "--clear-cache" ]]; then
        CLEAR_CACHE=true
    elif [[ $arg == "--clear-history" ]]; then
        CLEAR_HISTORY=true
    fi
done

echo "For preventing canvas fingerprinting, you can use browser extensions like CanvasBlocker."

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if a directory exists
directory_exists() {
    [ -d "$1" ]
}

# Check if ProtonVPN is installed
if command_exists protonvpn; then
    # Switch IP
    sudo protonvpn c -r
else
    echo "ProtonVPN is not installed."
fi

# Check if Mozilla directory exists
MOZILLA_DIR=$(find ~/.mozilla/firefox/*.default -maxdepth 0 -type d 2>/dev/null)
if directory_exists "$MOZILLA_DIR"; then
    # Clear cookies
    sqlite3 "$MOZILLA_DIR/cookies.sqlite" "DELETE FROM moz_cookies"

    # Clear cache
    if $CLEAR_CACHE; then
        rm -rf "$MOZILLA_DIR/cache2"
    fi

    # Clear history
    if $CLEAR_HISTORY; then
        sqlite3 "$MOZILLA_DIR/places.sqlite" "DELETE FROM moz_places"
    fi

    # Change user agent
    echo 'user_pref("general.useragent.override", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3");' >> "$MOZILLA_DIR/user.js"
else
    echo "Mozilla ~/.mozilla/firefox/ directory not found."
fi

# Function to handle browser data
handle_browser_data() {
    DIR=$1
    FLAGS_URL=$2
    if directory_exists "$DIR"; then
        # Clear cookies
        rm "$DIR/Cookies"

        # Clear cache
        if $CLEAR_CACHE; then
            rm -rf "$DIR/Cache"
        fi

        # Clear history
        if $CLEAR_HISTORY; then
            rm "$DIR/History"
        fi

        # Change user agent
        echo "$FLAGS_URL" >> "$DIR/Preferences"
    else
        echo "$DIR directory not found."
    fi
}

# Check if Chrome directory exists
handle_browser_data ~/.config/google-chrome/Default 'chrome://flags/#user-agent'

# Check if Edge directory exists
handle_browser_data ~/.config/microsoft-edge/Default 'edge://flags/#user-agent'

# Check if Brave directory exists
handle_browser_data ~/.config/BraveSoftware/Brave-Browser/Default 'brave://flags/#user-agent'
