import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  // Make sure the base is set to '/' for Netlify deployment
  base: '/',
  // Specify the build output
  build: {
    outDir: 'dist',
    emptyOutDir: true,
    // Ensure proper handling of assets
    assetsInlineLimit: 4096,
    // Configure the CSS output
    cssCodeSplit: true,
    rollupOptions: {
      // Make sure the entry point is correct
      input: {
        main: path.resolve(__dirname, 'index.html'),
      },
      output: {
        manualChunks: {
          vendor: ['react', 'react-dom', 'react-router-dom'],
        },
      },
    },
  },
})
