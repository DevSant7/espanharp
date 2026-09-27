import { Home } from "@views/pages/Home";
import { Inventory } from "@views/pages/Inventory";
import { Organizations } from "@views/pages/Organizations";
import { Players } from "@views/pages/Players";
import { Properties } from "@views/pages/Properties";
import { Salary } from "@views/pages/Salary";
import { Staff } from "@views/pages/Staff";
import { Vehicles } from "@views/pages/Vehicles";
import { Navigate, useRoutes } from "react-router-dom";

export function Router() {
  const routes = useRoutes([
    { path: "*", element: <Navigate to="/home" /> },
    { path: "/home", element: <Home /> },
    { path: "/players", element: <Players /> },
    { path: "/organizations", element: <Organizations /> },
    { path: "/salary", element: <Salary /> },
    { path: "/inventory", element: <Inventory /> },
    { path: "/vehicles", element: <Vehicles /> },
    { path: "/properties", element: <Properties /> },
    { path: "/staff", element: <Staff /> },
  ]);
  return routes;
}
