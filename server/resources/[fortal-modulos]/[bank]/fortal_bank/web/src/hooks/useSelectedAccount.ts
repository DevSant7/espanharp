import { useState, useEffect } from 'react';

export interface SelectedAccount {
  id: string;
  type: 'personal' | 'joint';
}

export function useSelectedAccount() {
  const [selectedAccount, setSelectedAccount] = useState<SelectedAccount | null>(null);

  useEffect(() => {
    // Carregar conta selecionada do localStorage
    const savedAccount = localStorage.getItem('selectedAccount');
    if (savedAccount) {
      try {
        const account = JSON.parse(savedAccount);
        setSelectedAccount(account);
      } catch (error) {
        console.error('Erro ao carregar conta selecionada:', error);
      }
    }
  }, []);

  const updateSelectedAccount = (account: SelectedAccount) => {
    setSelectedAccount(account);
    localStorage.setItem('selectedAccount', JSON.stringify(account));
  };

  const clearSelectedAccount = () => {
    setSelectedAccount(null);
    localStorage.removeItem('selectedAccount');
  };

  return {
    selectedAccount,
    updateSelectedAccount,
    clearSelectedAccount,
    isPersonalAccount: selectedAccount?.type === 'personal',
    isJointAccount: selectedAccount?.type === 'joint'
  };
}
