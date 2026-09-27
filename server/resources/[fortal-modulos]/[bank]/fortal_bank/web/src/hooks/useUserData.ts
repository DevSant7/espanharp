import { useState, useEffect, useCallback } from 'react';
import { fetchNui } from '../app/utils/fetchNui';

interface UserData {
  id: number;
  name: string;
  bank: number;
}

// Estado global para persistir os dados
let globalUserData: UserData | null = null;

export function useUserData() {
  const [userData, setUserData] = useState<UserData | null>(globalUserData);

  const refreshUserData = useCallback(async () => {
    try {
      const result = await fetchNui<{ success: boolean; data: UserData }>('refreshUserData');
      if (result && result.success && result.data) {
        console.log('FORTAL_BANK: Dados do usuário atualizados:', result.data);
        globalUserData = result.data;
        setUserData(result.data);
      }
    } catch (error) {
      console.error('FORTAL_BANK: Erro ao atualizar dados do usuário:', error);
    }
  }, []);

  useEffect(() => {
    console.log('FORTAL_BANK: useEffect executando - configurando event listener');
    
    // Escutar mensagens do servidor
    const handleMessage = (event: MessageEvent) => {
      const { action, data } = event.data;
      
      console.log('FORTAL_BANK: Mensagem recebida:', action, data);
      
      if (action === 'setUserData') {
        console.log('FORTAL_BANK: Definindo dados do usuário:', data);
        globalUserData = data; // Persistir globalmente
        setUserData(data);
        console.log('FORTAL_BANK: setUserData chamado com:', data);
      } else if (action === 'refreshAllData') {
        console.log('FORTAL_BANK: Recarregando dados do usuário...');
        refreshUserData();
      }
    };

    window.addEventListener('message', handleMessage);
    
    return () => {
      console.log('FORTAL_BANK: useEffect cleanup - removendo event listener');
      window.removeEventListener('message', handleMessage);
    };
  }, [refreshUserData]);

  console.log('FORTAL_BANK: useUserData renderizando com userData:', userData);
  return userData;
}
