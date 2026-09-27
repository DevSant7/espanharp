import { Fines } from "@views/pages/Fines";
import { Home } from "@views/pages/Home";
import { Investments } from "@views/pages/Investments";
import { Invoices } from "@views/pages/Invoices";
import { Login } from "@views/pages/Login";
import { Register } from "@views/pages/Register";
import { SettingsPage } from "@views/pages/Settings";
import { Transfer } from "@views/pages/Transfer";
import { Navigate, useRoutes, useLocation } from "react-router-dom";
import { useEffect } from "react";

export function Router() {
  const location = useLocation();
  
  // Forçar sempre para login quando não estiver em login ou register
  useEffect(() => {
    if (location.pathname !== "/login" && location.pathname !== "/register") {
      window.history.replaceState(null, '', '/login');
    }
  }, [location.pathname]);

  const routes = useRoutes([
    { path: "/", element: <Navigate to="/login" replace /> },
    { path: "/login", element: <Login /> },
    { path: "/register", element: <Register /> },
    { path: "/home", element: <Home /> },
    { path: "/investments", element: <Investments /> },
    { path: "/transfer", element: <Transfer /> },
    { path: "/invoice", element: <Invoices /> },
    { path: "/fines", element: <Fines /> },
    { path: "/player", element: <SettingsPage /> },
    { path: "*", element: <Navigate to="/login" replace /> },
  ]);
  return routes;
}
