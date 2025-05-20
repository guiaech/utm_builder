
#!/bin/bash

# Print environment information
echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"

# Install dependencies
echo "Installing dependencies..."
npm install

# Create necessary TypeScript config files
echo "Creating TypeScript configuration files..."

# Create tsconfig.node.json
cat > tsconfig.node.json << EOL
{
  "compilerOptions": {
    "composite": true,
    "skipLibCheck": true,
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowSyntheticDefaultImports": true
  },
  "include": ["vite.config.ts"]
}
EOL

# Create simplified tsconfig.json
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

echo "Running TypeScript compiler with npx..."
# Run TypeScript compiler using npx to ensure it uses the local installation
npx tsc --noEmit

# If TypeScript compilation succeeds, run the Vite build
if [ $? -eq 0 ]; then
  echo "TypeScript compilation successful. Building with Vite..."
  npx vite build
else
  echo "TypeScript compilation failed."
  exit 1
fi
