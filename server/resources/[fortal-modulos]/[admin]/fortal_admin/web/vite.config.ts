import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import * as path from "node:path";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  base: "./",
  build: {
    outDir: "build",
  },
  resolve: {
    alias: {
      "@views": path.resolve(__dirname, "src", "views"),
      "@app": path.resolve(__dirname, "src", "app"),
    },
  },
});
