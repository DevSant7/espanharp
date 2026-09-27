import { createElement } from "react";
import { Route, Routes } from "react-router-dom";

import { Background } from "@/components/Background";
import Camera from "./components/Camera";
import Navigation from "./components/Navigation";
import { Pages } from "./constants/Pages";

export default function Creator() {
  return (
    <Background>
      <aside className="flex h-full w-[9.63rem] flex-none items-center justify-center">
        <Navigation />
      </aside>
      <main className="flex h-screen w-full items-center overflow-visible">
        <Camera />
        <Routes>
          {Object.keys(Pages).map((id: string) => {
            const path = id == "1" ? "/" : id;
            const data = Pages[id];
            return (
              <Route
                key={id}
                path={path}
                element={createElement(data.component)}
              />
            );
          })}
        </Routes>
      </main>
    </Background>
  );
}
