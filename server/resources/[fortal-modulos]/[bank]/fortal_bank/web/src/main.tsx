import React from "react";
import ReactDOM from "react-dom/client";
import { VisibilityProvider } from "@app/providers/VisibilityProvider";

import { App } from "./App";

import "@views/styles/index.css";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <VisibilityProvider>
      <App />
    </VisibilityProvider>
  </React.StrictMode>
);
