import { Route, Routes, Navigate } from "react-router-dom";

import { Panel } from "@/pages/App/Panel";
import { Time } from "@/pages/App/Time";

export const Interface = () => {
  return (
    <main className="flex h-screen items-center justify-center">
      <Routes>
        <Route path="/" element={<Navigate to="/panel" replace />} />
        <Route path="/panel/*" element={<Panel />} />
        <Route path="/time/*" element={<Time />} />
      </Routes>
    </main>
  );
};
