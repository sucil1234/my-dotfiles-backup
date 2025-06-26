#!/bin/bash

# --- CONFIGURATION ---
API_KEY="55a6b6b637785ffb87487255e565373f"
LAT="-33.75"
LON="151.28"
# --- END CONFIGURATION ---

URL="https://api.openweathermap.org/data/2.5/weather?lat=${LAT}&lon=${LON}&appid=${API_KEY}&units=metric"

weather=$(curl -s "$URL")

# Check if the API call was successful (HTTP code 200)
if [ "$(echo "$weather" | jq -r '.cod')" == "200" ]; then
    temp=$(echo "$weather" | jq '.main.temp | round')
    condition=$(echo "$weather" | jq -r '.weather[0].main')
    echo "+${temp}°C ${condition}"
else
    # If not successful, print the error message from the API
    error_message=$(echo "$weather" | jq -r '.message')
    echo "API Error: $error_message"
fi
