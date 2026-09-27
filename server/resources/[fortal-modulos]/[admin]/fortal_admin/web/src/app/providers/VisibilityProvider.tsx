import React, {
  Context,
  createContext,
  useContext,
  useEffect,
  useState,
} from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
import { isEnvBrowser } from "../utils/misc";

const VisibilityCtx = createContext<VisibilityProviderValue | null>(null);

interface VisibilityProviderValue {
  setVisible: (visible: boolean) => void;
  visible: boolean;
  refreshData: () => void;
}

export const VisibilityProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [visible, setVisible] = useState(false);

  useNuiEvent<boolean>("setVisible", setVisible);

  // Função para atualizar todos os dados do painel
  const refreshData = () => {
    console.log("🔄 [VISIBILITY] Atualizando dados do painel...");
    
    // Buscar dados principais do dashboard
    fetchNui("getNotifications");
    fetchNui("getOnlinePlayers");
    fetchNui("getServerData");
    fetchNui("getChatMessages");
    fetchNui("getUserInfo");
    
    // Nota: Dados específicos de páginas são atualizados pelos hooks useAutoRefresh
  };

  useEffect(() => {
    if (!visible) return;

    // Quando o painel se torna visível, sempre atualizar os dados
    refreshData();

    const keyHandler = (e: KeyboardEvent) => {
      if (["Escape"].includes(e.code)) {
        if (!isEnvBrowser()) fetchNui("hideFrame");
        else setVisible(!visible);
      }
    };

    window.addEventListener("keydown", keyHandler);

    return () => window.removeEventListener("keydown", keyHandler);
  }, [visible]);

  return (
    <VisibilityCtx.Provider
      value={{
        visible,
        setVisible,
        refreshData,
      }}
    >
      <div style={{ visibility: visible ? "visible" : "hidden" }}>
        {children}
      </div>
    </VisibilityCtx.Provider>
  );
};

export const useVisibility = () =>
  useContext<VisibilityProviderValue>(
    VisibilityCtx as Context<VisibilityProviderValue>
  );
