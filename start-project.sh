#!/bin/bash

# Determine the npm script to run based on the argument
frontend_script="start"
backend_script="start"
if [ "$1" == "--dev" ]; then
  frontend_script="dev"
  backend_script="start:dev"
fi

# Function to handle SIGINT signal
handle_interrupt() {
  kill $frontend_pid $backend_pid
  exit
}

# Register the function to handle SIGINT
trap 'handle_interrupt' SIGINT

# Navigate to the frontend directory and run the Next.js project
cd ./frontend && npm run $frontend_script & frontend_pid=$!

# Navigate to the backend directory and run the Nest.js project
cd ./backend && npm run $backend_script & backend_pid=$!

# Wait for both processes to finish
wait $frontend_pid $backend_pid