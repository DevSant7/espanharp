import { useState, useEffect, useCallback } from 'react';
import { fetchNui } from '../app/utils/fetchNui';

export interface AccountInfo {
  id?: number;
  user_id: number;
  profile_photo?: string;
  full_name: string;
  nickname: string;
  username: string;
  gender: 'masculino' | 'feminino';
  transfer_key_type: 'usuario' | 'passaporte' | 'registro';
  security_pin: string;
  created_at?: string;
  updated_at?: string;
}

export function useAccountInfo() {
  const [accountInfo, setAccountInfo] = useState<AccountInfo | null>(null);
  const [loading, setLoading] = useState<boolean>(true);

  const loadAccountInfo = useCallback(async () => {
    try {
      setLoading(true);
      const result = await fetchNui('getAccountInfo');
      console.log('useAccountInfo: Dados recebidos:', result);
      setAccountInfo(result || null);
    } catch (error) {
      console.error('Erro ao carregar informações da conta:', error);
      setAccountInfo(null);
    } finally {
      setLoading(false);
    }
  }, []);

  const updateAccountInfo = useCallback(async (data: Partial<AccountInfo>) => {
    try {
      const result = await fetchNui('updateAccountInfo', data);
      if (result) {
        await loadAccountInfo(); // Recarregar dados após atualização
        return true;
      }
      return false;
    } catch (error) {
      console.error('Erro ao atualizar informações da conta:', error);
      return false;
    }
  }, [loadAccountInfo]);

  const resetSecurityPin = useCallback(async () => {
    try {
      const result = await fetchNui('resetSecurityPin');
      if (result) {
        await loadAccountInfo(); // Recarregar dados após reset
        return true;
      }
      return false;
    } catch (error) {
      console.error('Erro ao resetar PIN de segurança:', error);
      return false;
    }
  }, [loadAccountInfo]);

  useEffect(() => {
    loadAccountInfo();
  }, [loadAccountInfo]);

  // Listener para refresh automático quando o banco abre
  useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
      const { action } = event.data;
      if (action === 'refreshAllData') {
        console.log('FORTAL_BANK: Recarregando informações da conta...');
        loadAccountInfo();
      }
    };

    window.addEventListener('message', handleMessage);
    return () => window.removeEventListener('message', handleMessage);
  }, [loadAccountInfo]);

  return {
    accountInfo,
    loading,
    updateAccountInfo,
    resetSecurityPin,
    refreshAccountInfo: loadAccountInfo
  };
}
