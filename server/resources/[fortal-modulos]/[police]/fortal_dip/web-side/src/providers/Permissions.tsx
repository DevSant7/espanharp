import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';

interface PlayerRankInfo {
  rank?: number;
  name?: string;
  label?: string;
  restrictedPages?: string[];
  permissions?: {
    canHire?: boolean;
    canFire?: boolean;
    canPromote?: boolean;
    canDemote?: boolean;
    canAnnounce?: boolean;
    canWanted?: boolean;
    canRemoveWanted?: boolean;
    canViewHistory?: boolean;
    canEditHistory?: boolean;
    canViewStats?: boolean;
    canViewMembers?: boolean;
    canEditMembers?: boolean;
    canPrison?: boolean;
    canFine?: boolean;
    canSearch?: boolean;
    canLocked?: boolean;
  };
}

interface PermissionsContextType {
  playerRankInfo: PlayerRankInfo | null;
  loading: boolean;
  canAccessPage: (pageName: string) => boolean;
  canPerformAction: (action: string) => boolean;
}

const PermissionsContext = createContext<PermissionsContextType | undefined>(undefined);

export const usePermissions = () => {
  const context = useContext(PermissionsContext);
  if (context === undefined) {
    // Retornar valores padrão se o contexto não estiver disponível
    return {
      playerRankInfo: null,
      loading: false,
      canAccessPage: () => true, // Permitir acesso por padrão
      canPerformAction: () => true, // Permitir ações por padrão
    };
  }
  return context;
};

interface PermissionsProviderProps {
  children: ReactNode;
}

export const PermissionsProvider: React.FC<PermissionsProviderProps> = ({ children }) => {
  const [playerRankInfo, setPlayerRankInfo] = useState<PlayerRankInfo | null>(null);
  const [loading, setLoading] = useState(false); // Começar como false para não bloquear a abertura

  useEffect(() => {
    const fetchPlayerInfo = async () => {
      try {
        setLoading(true);
        const response = await fetch('https://fortal_dip/getPlayerRankInfo', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({}),
        });
        
        if (response.ok) {
          const data = await response.json();
          setPlayerRankInfo(data);
        }
      } catch (error) {
        console.error('Erro ao buscar informações do jogador:', error);
        // Em caso de erro, permitir acesso por padrão
        setPlayerRankInfo({
          rank: 1,
          name: "Default",
          label: "Default",
          restrictedPages: [],
          permissions: {
            canHire: true,
            canFire: true,
            canPromote: true,
            canDemote: true,
            canAnnounce: true,
            canWanted: true,
            canRemoveWanted: true,
            canViewHistory: true,
            canEditHistory: true,
            canViewStats: true,
            canViewMembers: true,
            canEditMembers: true,
            canPrison: true,
            canFine: true,
            canSearch: true,
            canLocked: true
          }
        });
      } finally {
        setLoading(false);
      }
    };

    // Listener para atualização de permissões
    const handleMessage = (event: MessageEvent) => {
      if (event.data.action === 'updatePermissions') {
        // Recarregar informações do jogador quando as permissões são atualizadas
        fetchPlayerInfo();
      }
    };

    window.addEventListener('message', handleMessage);

    // Sempre tentar buscar informações do jogador
    fetchPlayerInfo();

    return () => {
      window.removeEventListener('message', handleMessage);
    };
  }, []);

  const canAccessPage = (pageName: string) => {
    if (!playerRankInfo || !playerRankInfo.restrictedPages) {
      return true; // Se não há informações, permite acesso
    }
    
    const hasAccess = !playerRankInfo.restrictedPages.includes(pageName);
    return hasAccess;
  };

  const canPerformAction = (action: string) => {
    if (!playerRankInfo || !playerRankInfo.permissions) {
    
      return true; // Se não há informações, permite acesso
    }
    
    const hasPermission = playerRankInfo.permissions[action as keyof typeof playerRankInfo.permissions] === true;
   
    return hasPermission;
  };

  const value = {
    playerRankInfo,
    loading,
    canAccessPage,
    canPerformAction,
  };

  return (
    <PermissionsContext.Provider value={value}>
      {children}
    </PermissionsContext.Provider>
  );
}; 