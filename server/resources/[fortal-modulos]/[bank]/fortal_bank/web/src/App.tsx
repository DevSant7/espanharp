import { BrowserRouter, useLocation, useNavigate } from "react-router-dom";
import { Router } from "@app/Router";
import { isEnvBrowser } from "@app/utils/misc";
import clsx from "clsx";
import Sidebar from "@views/components/sidebar";
import { Separator } from "@views/components/ui/separator";
import { Notification } from "@views/components/Notification";
import { useEffect } from "react";
import { useNuiEvent } from "@app/hooks/useNuiEvent";

export function App() {
  return (
    <BrowserRouter>
      <InnerApp />
    </BrowserRouter>
  );
}

function InnerApp() {
  const location = useLocation();
  const navigate = useNavigate();

  // Sempre forçar para login quando a aplicação for carregada
  useEffect(() => {
    // Limpar qualquer estado anterior e forçar para login
    window.history.replaceState(null, '', '/login');
    navigate("/login", { replace: true });
  }, []);

  // Escutar o evento para forçar login
  useNuiEvent<boolean>("forceLogin", () => {
    // Limpar histórico e forçar para login
    window.history.replaceState(null, '', '/login');
    navigate("/login", { replace: true });
  });

  const isLogin =
    location.pathname === "/login" ||
    location.pathname.startsWith("/login?") ||
    location.pathname === "/register" ||
    location.pathname.startsWith("/register?");

  if (isLogin)
    return (
      <div
        className={clsx(
          "w-screen h-screen antialiased flex items-center justify-center",
          isEnvBrowser() && "bg-zinc-700"
        )}
      >
        <Router />
      </div>
    );

  return (
    <div
      className={clsx(
        "w-screen h-screen antialiased flex items-center justify-center",
        isEnvBrowser() && "bg-zinc-700"
      )}
    >
      <Notification />
      <div
        className="w-[80rem] h-[50rem] border border-[#22222B] rounded-[1rem] flex items-start justify-start"
        style={{
          background:
            "radial-gradient(225.81% 158.7% at -22.15% 177.94%, rgba(60, 142, 220, 0.05) 0%, rgba(0, 0, 0, 0.05) 100%), linear-gradient(108deg, rgba(14, 17, 28, 0.97) 0%, rgba(5, 4, 5, 0.97) 100%)",
        }}
      >
        <Sidebar />
        <Separator className="h-full bg-[#FFFFFF08]" orientation="vertical" />
        <Router />
      </div>
    </div>
  );
}
