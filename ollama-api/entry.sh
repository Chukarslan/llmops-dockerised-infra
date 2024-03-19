#!/bin/bash

# Start the main application
ollama serve &

# Wait for the main application to start
sleep 10

# Define the maximum number of retries
max_retries=3
retries=0

# Define flags to track command execution
mistral_pulled=false
nomic_embed_text_pulled=false

while [[ $retries -lt $max_retries ]]; do
    # Check if the main application is running
    if pgrep -x "ollama" > /dev/null; then
        # If the main application is running, execute additional commands
        echo "Main application is running. Proceeding with additional commands."
        
        # Pull the 'mistral' package if not already pulled
        if [[ "$mistral_pulled" == "false" ]]; then
            echo "Pulling 'mistral' package..."
            ollama pull mistral
            mistral_pulled=true
        else
            echo "'mistral' package already pulled."
        fi
        
        # Pull the 'nomic-embed-text' package if not already pulled
        if [[ "$nomic_embed_text_pulled" == "false" ]]; then
            echo "Pulling 'nomic-embed-text' package..."
            ollama pull nomic-embed-text
            nomic_embed_text_pulled=true
        else
            echo "'nomic-embed-text' package already pulled."
        fi
        
        # Keep the container running
        tail -f /dev/null
    else
        echo "Main application is not running. Retrying..."
        ((retries++))
        sleep 10  # Wait before retrying
    fi
done

echo "Maximum retries reached. Exiting."
exit 1
