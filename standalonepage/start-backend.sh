#!/bin/bash

# Navigate to backend directory
cd backend

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
fi

# Check if .env exists
if [ ! -f ".env" ]; then
    echo "Creating .env file..."
    echo "PORT=5000
NODE_ENV=development
EMAIL_USER=your-email@gmail.com
EMAIL_PASS=your-app-specific-password" > .env
    echo "Please update the .env file with your email credentials"
fi

# Start the server
echo "Starting backend server..."
npm run dev 