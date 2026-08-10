import inertia from '@inertiajs/vite'
import tailwindcss from '@tailwindcss/vite'
import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'

export default defineConfig({
  plugins: [
    tailwindcss(),
    RubyPlugin(),
    vue(),
    vueDevTools({
      appendTo: 'app/frontend/entrypoints/inertia.ts',
    }),
    inertia(),
  ],
  build: {
    rollupOptions: {
      external: [/\.node$/, 'fsevents'],
    },
  },
})