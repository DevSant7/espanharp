import * as path from "path";

import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";

export default defineConfig({
  plugins: [react()],
  base: "./",
  server: {
    open: true,
    port: 3000,
  },
  build: {
    outDir: "../nui",
    sourcemap: false,
    minify: "esbuild",
  },
  resolve: {
    alias: {
      "@": path.resolve("./src"),
    },
  },
});
