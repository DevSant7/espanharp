import "@/style/global.css";

import { BrowserRouter, Route, Routes, Navigate } from "react-router-dom";

import ReactDOM from "react-dom/client";
import Barbershop from "./pages/Barbershop";
import Creator from "./pages/Creator";
import Skinshop from "./pages/Skinshop";
import Selector from "./pages/Selector";
import Tattooshop from "./pages/Tattooshop";
import Spawn from "./pages/Spawn";
import { Debugger } from "@/utils/debugger";
import { VisibilityProvider } from "@/providers/Visibility";

new Debugger([
  {
    action: "setColor",
    data: "60, 142, 220",
  },
  // {
  //   action: "setVisibility",
  //   data: "skinshop",
  // },
]);

ReactDOM.createRoot(document.getElementById("root")!).render(
  <BrowserRouter>
    <VisibilityProvider>
      <Routes>
        <Route path="/" element={<></>} />
        <Route path="/creator/*" element={<Creator />} />
        <Route path="/tattooshop" element={<Tattooshop />} />
        <Route path="/barbershop" element={<Barbershop />} />
        <Route path="/skinshop/*" element={<Skinshop />} />
        <Route path="/selector" element={<Selector />} />
        <Route path="/spawn" element={<Spawn />} />
        <Route path="*" element={<Navigate to="/" />} />
      </Routes>
    </VisibilityProvider>
  </BrowserRouter>
);
