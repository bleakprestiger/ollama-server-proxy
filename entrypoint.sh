#!/bin/bash

# Starting server
echo "Starting ollama proxy server"
#ollama serve &
ollama_proxy_server --config ./config.ini --users_list ./authorized_users.txt --port 7860 &
sleep 1

# Splitting the models by comma and pulling each
#IFS=',' read -ra MODELS <<< "$model"
#for m in "${MODELS[@]}"; do
#    echo "Pulling $m"
#    ollama pull "$m"
#    sleep 5
    # echo "Running $m"
    # ollama run "$m"
    # No need to sleep here unless you want to give some delay between each pull for some reason
#done

# Keep the script running to prevent the container from exiting
wait