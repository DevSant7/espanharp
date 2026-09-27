import React, { useState, useEffect } from "react";
import { formatCurrency as formatBRL } from "../../utils/formatCurrency";
import { ArrowUpRight, ArrowDownLeft, ArrowLeftRight } from "lucide-react";
import { fetchNui } from "../../app/utils/fetchNui";
import { useSelectedAccount } from "../../hooks/useSelectedAccount";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@views/components/ui/table";

// Declaração de tipos para window
declare global {
  interface Window {
    refreshTransactions?: () => void;
  }
}

interface Transaction {
  id: number;
  description: string;
  value: number;
  type: string;
  date: string;
}

interface TransactionTableProps {
  className?: string;
  onTransactionUpdate?: () => void;
}

const TransactionTable: React.FC<TransactionTableProps> = ({ className, onTransactionUpdate }) => {
  const [transactions, setTransactions] = useState<Transaction[]>([]);
  const { selectedAccount, isPersonalAccount, isJointAccount } = useSelectedAccount();

  useEffect(() => {
    loadTransactions();
  }, [selectedAccount]);

  // Expor função para atualizar transações
  useEffect(() => {
    console.log('TransactionTable: Definindo window.refreshTransactions');
    window.refreshTransactions = loadTransactions;
    return () => {
      console.log('TransactionTable: Removendo window.refreshTransactions');
      window.refreshTransactions = undefined;
    };
  }, [selectedAccount, isPersonalAccount, isJointAccount]);

  const loadTransactions = async () => {
    console.log('TransactionTable: Carregando transações para conta:', selectedAccount);
    try {
      const result = await fetchNui('getTransactions', {
        accountType: isJointAccount ? 'joint' : 'personal',
        accountId: selectedAccount?.id
      });
      console.log('TransactionTable: Transações recebidas:', result);
      setTransactions(result || []);
    } catch (error) {
      console.error('Erro ao carregar transações:', error);
    }
  };

  const getTransactionIcon = (type: string) => {
    const lowerType = type.toLowerCase();
    if (lowerType.includes("depósito") || lowerType.includes("deposito")) {
      return <ArrowUpRight size={14} className="text-green-400" />;
    } else if (lowerType.includes("saque")) {
      return <ArrowDownLeft size={14} className="text-red-400" />;
    } else {
      return <ArrowLeftRight size={14} className="text-yellow-400" />;
    }
  };

  const formatCurrency = (value: number) => {
    return `$ ${formatBRL(value)}`;
  };


  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const year = date.getFullYear();
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    
    return {
      date: `${day}/${month}/${year}`,
      time: `${hours}:${minutes}`
    };
  };

  return (
    <div
      className={`flex flex-col rounded-md p-6 h-[13.5rem] ${className}`}
      style={{
        background:
          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
      }}
    >
      <div className="flex items-center gap-2 mb-4">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width=".625rem"
          height=".625rem"
          viewBox="0 0 10 10"
          fill="none"
        >
          <path
            d="M0 5C0 5.14734 0.0585316 5.28865 0.162718 5.39284C0.266905 5.49702 0.408213 5.55556 0.555556 5.55556H3.88889C4.03623 5.55556 4.17754 5.49702 4.28173 5.39284C4.38591 5.28865 4.44444 5.14734 4.44444 5V0.555556C4.44444 0.408213 4.38591 0.266905 4.28173 0.162718C4.17754 0.0585316 4.03623 0 3.88889 0H0.555556C0.408213 0 0.266905 0.0585316 0.162718 0.162718C0.0585316 0.266905 0 0.408213 0 0.555556V5ZM0 9.44444C0 9.59179 0.0585316 9.7331 0.162718 9.83728C0.266905 9.94147 0.408213 10 0.555556 10H3.88889C4.03623 10 4.17754 9.94147 4.28173 9.83728C4.38591 9.7331 4.44444 9.59179 4.44444 9.44444V7.22222C4.44444 7.07488 4.38591 6.93357 4.28173 6.82939C4.17754 6.7252 4.03623 6.66667 3.88889 6.66667H0.555556C0.408213 6.66667 0.266905 6.7252 0.162718 6.82939C0.0585316 6.93357 0 7.07488 0 7.22222V9.44444ZM5.55556 9.44444C5.55556 9.59179 5.61409 9.7331 5.71827 9.83728C5.82246 9.94147 5.96377 10 6.11111 10H9.44444C9.59179 10 9.7331 9.94147 9.83728 9.83728C9.94147 9.7331 10 9.59179 10 9.44444V5C10 4.85266 9.94147 4.71135 9.83728 4.60716C9.7331 4.50298 9.59179 4.44444 9.44444 4.44444H6.11111C5.96377 4.44444 5.82246 4.50298 5.71827 4.60716C5.61409 4.71135 5.55556 4.85266 5.55556 5V9.44444ZM6.11111 0C5.96377 0 5.82246 0.0585316 5.71827 0.162718C5.61409 0.266905 5.55556 0.408213 5.55556 0.555556V2.77778C5.55556 2.92512 5.61409 3.06643 5.71827 3.17061C5.82246 3.2748 5.96377 3.33333 6.11111 3.33333H9.44444C9.59179 3.33333 9.7331 3.2748 9.83728 3.17061C9.94147 3.06643 10 2.92512 10 2.77778V0.555556C10 0.408213 9.94147 0.266905 9.83728 0.162718C9.7331 0.0585316 9.59179 0 9.44444 0H6.11111Z"
            fill="white"
            fill-opacity="0.25"
          />
        </svg>
        <h3 className="text-white/40 text-sm font-normal">
          Transações recentes
        </h3>
      </div>

      <div className="flex-1 overflow-auto scrollbar-hide">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead className="text-white/40 text-xs font-normal">
                Descrição
              </TableHead>
              <TableHead className="text-white/40 text-xs font-normal">
                Valor
              </TableHead>
              <TableHead className="text-white/40 text-xs font-normal">
                Tipo
              </TableHead>
              <TableHead className="text-white/40 text-xs font-normal">
                Horário
              </TableHead>
              <TableHead className="text-white/40 text-xs font-normal text-right">
                Data
              </TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {transactions.length === 0 ? (
              <TableRow>
                <TableCell colSpan={5} className="text-center text-white/40 text-sm">
                  Nenhuma transação encontrada
                </TableCell>
              </TableRow>
            ) : (
              transactions.map((transaction) => {
                const { date, time } = formatDate(transaction.date);
                return (
                  <TableRow key={transaction.id}>
                    <TableCell>
                      <span className="text-white text-xs font-medium">
                        {transaction.description}
                      </span>
                    </TableCell>
                    <TableCell>
                      <span className="text-white text-xs font-semibold">
                        {formatCurrency(transaction.value)}
                      </span>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        {getTransactionIcon(transaction.type)}
                        <span className="text-white/40 text-xs">
                          {transaction.type}
                        </span>
                      </div>
                    </TableCell>
                    <TableCell>
                      <span className="text-white/60 text-xs">{time}</span>
                    </TableCell>
                    <TableCell className="text-right">
                      <span className="text-white/40 text-xs">
                        {date}
                      </span>
                    </TableCell>
                  </TableRow>
                );
              })
            )}
          </TableBody>
        </Table>
      </div>
    </div>
  );
};

export default TransactionTable;
