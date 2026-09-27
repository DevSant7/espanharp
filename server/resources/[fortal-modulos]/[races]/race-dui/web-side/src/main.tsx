import "@/style/global.css";

import Interface from "@/components/Interface";
import React from "react";
import ReactDOM from "react-dom/client";
import { VisibilityProvider } from "@/providers/Visibility";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <VisibilityProvider>
      <Interface />
    </VisibilityProvider>
  </React.StrictMode>,
);
