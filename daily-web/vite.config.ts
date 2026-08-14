import { fileURLToPath, URL } from 'node:url'
import vue from '@vitejs/plugin-vue'
import { defineConfig } from 'vitest/config'

export default defineConfig({
  plugins: [vue()],
  resolve: { alias: { '@': fileURLToPath(new URL('./src', import.meta.url)) } },
  server: {
    port: 5180,
    host: '0.0.0.0',
    // In container, Vite can't reach Spring Boot via localhost — fall back to the
    // compose service name when the env var is set (set in docker-compose.dev.yml).
    // CLI --port (used by docker-compose.dev.yml) overrides this default.
    proxy: {
      '/api': {
        target: process.env.VITE_API_PROXY ?? 'http://localhost:8080',
        changeOrigin: true,
      },
    },
  },
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: './tests/setup.ts',
    exclude: ['e2e/**', 'node_modules/**', 'dist/**'],
  },
})
