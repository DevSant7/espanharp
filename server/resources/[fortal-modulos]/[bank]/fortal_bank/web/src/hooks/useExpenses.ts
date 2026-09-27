import { useState, useEffect } from 'react';
import { fetchNui } from '../app/utils/fetchNui';
import { useSelectedAccount } from './useSelectedAccount';

export function useExpenses() {
  const [expenses, setExpenses] = useState<number>(0);
  const [loading, setLoading] = useState<boolean>(true);
  const { selectedAccount, isPersonalAccount, isJointAccount } = useSelectedAccount();

  const loadExpenses = async () => {
    try {
      setLoading(true);
      const result = await fetchNui('getExpensesLast4Weeks', {
        accountType: isJointAccount ? 'joint' : 'personal',
        accountId: selectedAccount?.id
      });
      setExpenses(result || 0);
    } catch (error) {
      console.error('Erro ao carregar despesas:', error);
      setExpenses(0);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadExpenses();
  }, [selectedAccount, isPersonalAccount, isJointAccount]);

  // Listener para refresh automático quando o banco abre
  useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
      const { action } = event.data;
      if (action === 'refreshAllData') {
        console.log('FORTAL_BANK: Recarregando despesas...');
        loadExpenses();
      }
    };

    window.addEventListener('message', handleMessage);
    return () => window.removeEventListener('message', handleMessage);
  }, [selectedAccount, isPersonalAccount, isJointAccount]);

  return {
    expenses,
    loading,
    refreshExpenses: loadExpenses
  };
}
