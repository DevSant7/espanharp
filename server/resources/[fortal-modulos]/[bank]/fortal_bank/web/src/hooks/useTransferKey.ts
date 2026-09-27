import { useState, useEffect, useCallback } from 'react';
import { fetchNui } from '../app/utils/fetchNui';

export function useTransferKey() {
  const [transferKey, setTransferKey] = useState<string | null>(null);
  const [loading, setLoading] = useState<boolean>(true);

  const loadTransferKey = useCallback(async () => {
    try {
      setLoading(true);
      const result = await fetchNui<string>('getTransferKey');
      if (result) {
        setTransferKey(result);
      } else {
        setTransferKey(null);
      }
    } catch (error) {
      console.error('Erro ao carregar chave de transferência:', error);
      setTransferKey(null);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    loadTransferKey();
  }, [loadTransferKey]);

  // Listener para refresh automático quando o banco abre
  useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
      const { action } = event.data;
      if (action === 'refreshAllData') {
        console.log('FORTAL_BANK: Recarregando chave de transferência...');
        loadTransferKey();
      }
    };

    window.addEventListener('message', handleMessage);
    return () => window.removeEventListener('message', handleMessage);
  }, [loadTransferKey]);

  return {
    transferKey,
    loading,
    refreshTransferKey: loadTransferKey
  };
}
