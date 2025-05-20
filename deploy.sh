#!/bin/bash

# Simplified build script
echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"

# Install dependencies
npm install

# Create the tsconfig.node.json file if it doesn't exist
if [ ! -f "tsconfig.node.json" ]; then
  echo '{
    "compilerOptions": {
      "composite": true,
      "skipLibCheck": true,
      "module": "ESNext",
      "moduleResolution": "bundler",
      "allowSyntheticDefaultImports": true
    },
    "include": ["vite.config.ts"]
  }' > tsconfig.node.json
  echo "Created tsconfig.node.json"
fi

# Modify tsconfig.json to simplify the build process
cat > tsconfig.json << EOL
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"],
      "shared/*": ["./shared/*"]
    }
  },
  "include": ["src", "shared"]
}
EOL
echo "Updated tsconfig.json"

# Run the build command
echo "Running build..."
npm run build
