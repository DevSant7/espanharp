import { useEffect } from "react";
import { useVisibility } from "../providers/VisibilityProvider";
import { fetchNui } from "../utils/fetchNui";

/**
 * Hook personalizado para atualizar dados automaticamente quando o painel se torna visível
 * @param dataFetchers - Array de funções que fazem fetchNui para buscar dados
 * @param dependencies - Dependências opcionais para controlar quando os dados devem ser atualizados
 */
export const useAutoRefresh = (
  dataFetchers: (() => void)[],
  dependencies: any[] = []
) => {
  const { visible } = useVisibility();

  useEffect(() => {
    if (visible) {
      console.log("🔄 [AUTO-REFRESH] Atualizando dados automaticamente...");
      dataFetchers.forEach((fetcher, index) => {
        console.log(`🔄 [AUTO-REFRESH] Executando fetcher ${index + 1}/${dataFetchers.length}`);
        fetcher();
      });
    }
  }, [visible, ...dependencies]);
};

/**
 * Hook específico para buscar dados de jogadores
 */
export const usePlayersRefresh = () => {
  useAutoRefresh([
    () => fetchNui("getPlayers", ""),
  ]);
};

/**
 * Hook específico para buscar dados do dashboard
 */
export const useDashboardRefresh = () => {
  useAutoRefresh([
    () => fetchNui("getNotifications"),
    () => fetchNui("getOnlinePlayers"),
    () => fetchNui("getServerData"),
    () => fetchNui("getChatMessages"),
    () => fetchNui("getUserInfo"),
  ]);
};

/**
 * Hook específico para buscar dados de itens do servidor
 */
export const useItemsRefresh = () => {
  useAutoRefresh([
    () => fetchNui("getServerItems"),
  ]);
};

/**
 * Hook específico para buscar dados de veículos do servidor
 */
export const useVehiclesRefresh = () => {
  useAutoRefresh([
    () => fetchNui("getServerVehicles"),
  ]);
};

/**
 * Hook específico para buscar dados de organizações do servidor
 */
export const useOrganizationsRefresh = () => {
  useAutoRefresh([
    () => {
      console.log("🔄 [AUTO-REFRESH] Atualizando organizações automaticamente...");
      fetchNui("getServerOrganizations");
    },
  ]);
};

/**
 * Hook específico para buscar dados de staff do servidor
 */
export const useStaffRefresh = () => {
  useAutoRefresh([
    () => fetchNui("getServerStaff"),
  ]);
};
