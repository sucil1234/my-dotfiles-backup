#!/bin/bash

sleep 1 # Wait for 1 second to give hyprpaper time to start

# --- CONFIGURATION ---
# The directory where your wallpapers are stored
WALLPAPER_DIR="/home/sushil/.config/backgrounds/"

# The time to wait between wallpaper changes (e.g., 30m for 30 minutes, 1h for 1 hour)
SLEEP_DURATION="30m"
# --- END CONFIGURATION ---


# Check if the wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
  echo "Error: Wallpaper directory '$WALLPAPER_DIR' not found."
  exit 1
fi

# Main loop to continuously change the wallpaper
while true; do
  # Find all image files in the directory and select one at random.
  # 'find' is more robust than 'ls' for handling filenames with special characters.
  RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)

  # If a wallpaper was found, set it using hyprctl
  # This is the new, corrected code
if [ -n "$RANDOM_WALLPAPER" ]; then
  echo "Setting wallpaper to: $RANDOM_WALLPAPER"

  # 1. (Optional but good practice) Unload the old image from memory
  hyprctl hyprpaper unload all

  # 2. (THE FIX) Preload the new image into memory
  hyprctl hyprpaper preload "$RANDOM_WALLPAPER"

  # 3. Now, set the preloaded image as the wallpaper
  hyprctl hyprpaper wallpaper ",$RANDOM_WALLPAPER"

else
  echo "No wallpapers found in '$WALLPAPER_DIR'. Waiting before trying again."
fi

  # Wait for the specified duration before changing again
  sleep "$SLEEP_DURATION"
done
