import { useState, useEffect, useCallback } from 'react';
import { fetchNui } from '../app/utils/fetchNui';
import { useSelectedAccount } from './useSelectedAccount';

export interface Transaction {
  id: number;
  description: string;
  value: number;
  type: string;
  date: string;
  account_type: string;
  joint_account_id?: number;
}

export function useTransactions() {
  const [transactions, setTransactions] = useState<Transaction[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const { selectedAccount, isPersonalAccount, isJointAccount } = useSelectedAccount();

  const loadTransactions = useCallback(async () => {
    try {
      setLoading(true);
      const result = await fetchNui<Transaction[]>('getTransactions', {
        accountType: isJointAccount ? 'joint' : 'personal',
        accountId: selectedAccount?.id
      });
      
      if (result && Array.isArray(result)) {
        // Converter para o formato esperado pelo frontend
        const formattedTransactions = result.map((transaction: any) => ({
          id: transaction.id,
          description: transaction.description || 'Transação',
          value: transaction.value || 0,
          type: transaction.type || 'Transferência',
          date: transaction.date || new Date().toISOString(),
          account_type: transaction.account_type || 'personal',
          joint_account_id: transaction.joint_account_id
        }));
        
        setTransactions(formattedTransactions);
      } else {
        setTransactions([]);
      }
    } catch (error) {
      console.error('Erro ao carregar transações:', error);
      setTransactions([]);
    } finally {
      setLoading(false);
    }
  }, [selectedAccount, isPersonalAccount, isJointAccount]);

  useEffect(() => {
    loadTransactions();
  }, [loadTransactions]);

  // Listener para refresh automático quando o banco abre
  useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
      const { action } = event.data;
      if (action === 'refreshAllData') {
        console.log('FORTAL_BANK: Recarregando transações...');
        loadTransactions();
      }
    };

    window.addEventListener('message', handleMessage);
    return () => window.removeEventListener('message', handleMessage);
  }, [loadTransactions]);

  return {
    transactions,
    loading,
    refreshTransactions: loadTransactions
  };
}
