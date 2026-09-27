import "@/style/global.css";

import { Debugger } from "@/utils/debugger";
import { Interface } from "@/components/Interface";
import React from "react";
import ReactDOM from "react-dom/client";
import { VisibilityProvider } from "@/providers/Visibility";

new Debugger([
  {
    action: "setColor",
    data: "0, 140, 234",
  },
  {
    action: "setVisibility",
    data: true,
  },
  {
    action: "setTime",
    data: {
      month: 12,
      fine: 10000,
    },
  },
]);

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <VisibilityProvider>
      <Interface />
    </VisibilityProvider>
  </React.StrictMode>,
);
