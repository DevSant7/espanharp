import { useState, useEffect, useCallback } from 'react';
import { fetchNui } from '../app/utils/fetchNui';

export interface JointAccount {
  id: number;
  account_name: string;
  account_type: 'casal' | 'familia' | 'empresarial' | 'conjunto';
  balance: number;
  members: number[];
  created_by: number;
  created_at: string;
  updated_at: string;
}

export interface CreateJointAccountData {
  account_name: string;
  account_type: 'casal' | 'familia' | 'empresarial' | 'conjunto';
  participants: number[];
}

export function useJointAccounts() {
  const [jointAccounts, setJointAccounts] = useState<JointAccount[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  const loadJointAccounts = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const result = await fetchNui<JointAccount[]>('getUserJointAccounts');
      if (result) {
        setJointAccounts(result);
      } else {
        setJointAccounts([]);
      }
    } catch (err) {
      console.error('Failed to fetch joint accounts:', err);
      setError('Failed to load joint accounts.');
      setJointAccounts([]);
    } finally {
      setLoading(false);
    }
  }, []);

  const createJointAccount = useCallback(async (data: CreateJointAccountData) => {
    try {
      const result = await fetchNui<{ success: boolean; message?: string; account_id?: number }>('createJointAccount', data);
      if (result.success) {
        await loadJointAccounts(); // Recarregar lista
        return { success: true, account_id: result.account_id };
      } else {
        return { success: false, message: result.message || 'Erro ao criar conta' };
      }
    } catch (err) {
      console.error('Failed to create joint account:', err);
      return { success: false, message: 'Erro no servidor' };
    }
  }, [loadJointAccounts]);

  const getJointAccountBalance = useCallback(async (account_id: number) => {
    try {
      const balance = await fetchNui<number>('getJointAccountBalance', { account_id });
      return balance || 0;
    } catch (err) {
      console.error('Failed to get joint account balance:', err);
      return 0;
    }
  }, []);

  useEffect(() => {
    loadJointAccounts();
  }, [loadJointAccounts]);

  // Listener para refresh automático quando o banco abre
  useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
      const { action } = event.data;
      if (action === 'refreshAllData') {
        console.log('FORTAL_BANK: Recarregando contas conjuntas...');
        loadJointAccounts();
      }
    };

    window.addEventListener('message', handleMessage);
    return () => window.removeEventListener('message', handleMessage);
  }, [loadJointAccounts]);

  return { 
    jointAccounts, 
    loading, 
    error, 
    refreshJointAccounts: loadJointAccounts,
    createJointAccount,
    getJointAccountBalance
  };
}
