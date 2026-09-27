import * as path from "path";

import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";

export default defineConfig({
  plugins: [react()],
  base: "./",
  server: {
    port: 3001,
  },
  build: {
    outDir: "build",
    sourcemap: false,
    minify: "esbuild",
  },
  resolve: {
    alias: {
      "@": path.resolve("./src"),
    },
  },
});
