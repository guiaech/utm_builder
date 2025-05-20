#!/bin/bash

# Print environment information
echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"

# Clean install dependencies
echo "Installing dependencies..."
npm ci || npm install

# Run TypeScript compiler separately to see any errors clearly
echo "Running TypeScript compiler..."
npx tsc --noEmit

# Only proceed to build if TypeScript compilation succeeds
if [ $? -eq 0 ]; then
  echo "TypeScript compilation successful. Building..."
  npx vite build
else
  echo "TypeScript compilation failed."
  exit 1
fi
