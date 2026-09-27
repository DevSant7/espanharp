import React from "react";
import { ArrowLeftRight, User } from "lucide-react";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@views/components/ui/table";
import { useTransactions } from "../../hooks/useTransactions";

interface Transfer {
  id: string;
  description: string;
  value: number;
  type: "sent" | "received";
  time: string;
  date: string;
}

interface TransferHistoryProps {
  className?: string;
}

const TransferHistory: React.FC<TransferHistoryProps> = ({ className }) => {
  const { transactions, loading } = useTransactions();

  // Função para determinar se é saída ou entrada baseado no tipo de transação
  const getTransferType = (transaction: any): "sent" | "received" => {
    if (transaction.type === "Saque" || transaction.type === "Transferência") {
      return "sent";
    } else if (transaction.type === "Depósito") {
      return "received";
    }
    // Para transferências, verificar se contém "para" (saída) ou "de" (entrada)
    if (transaction.description && transaction.description.toLowerCase().includes("para")) {
      return "sent";
    } else if (transaction.description && transaction.description.toLowerCase().includes("de")) {
      return "received";
    }
    return "sent"; // default
  };

  const getTransferIcon = (type: "sent" | "received") => {
    return <ArrowLeftRight size={14} className="text-yellow-400" />;
  };

  const getTransferTypeLabel = (type: "sent" | "received") => {
    switch (type) {
      case "sent":
        return "Transferência";
      case "received":
        return "Transferência";
    }
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(value);
  };

  const getValueColor = (type: "sent" | "received") => {
    switch (type) {
      case "sent":
        return "text-red-400";
      case "received":
        return "text-green-400";
    }
  };

  const getValuePrefix = (type: "sent" | "received") => {
    switch (type) {
      case "sent":
        return "-";
      case "received":
        return "+";
    }
  };

  // Função para formatar data e hora
  const formatDateTime = (dateString: string) => {
    try {
      const date = new Date(dateString);
      const time = date.toLocaleTimeString('pt-BR', { 
        hour: '2-digit', 
        minute: '2-digit',
        hour12: false 
      });
      const dateFormatted = date.toLocaleDateString('pt-BR', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric'
      });
      return { time, date: dateFormatted };
    } catch (error) {
      return { time: "00:00", date: "01/01/2025" };
    }
  };

  // Filtrar apenas transferências para esta página (SOMENTE tipo "Transferência")
  const onlyTransfers = transactions.filter((t: any) => {
    if (!t) return false;
    const type = (t.type || '').toString().toLowerCase();
    // considera variações que contenham "transfer" (ex.: Transferência)
    return type.includes('transfer');
  });

  // Converter transações para o formato esperado
  const formattedTransfers: Transfer[] = onlyTransfers.map((transaction) => {
    const transferType = getTransferType(transaction);
    const { time, date } = formatDateTime(transaction.date);
    
    return {
      id: transaction.id.toString(),
      description: transaction.description,
      value: transaction.value,
      type: transferType,
      time,
      date
    };
  });

  return (
    <div
      className={`flex flex-col rounded-md p-6 h-[17.5rem] ${className}`}
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
            d="M7.50009 0.669946C8.25423 1.10537 8.88158 1.73021 9.32002 2.4826C9.75847 3.23498 9.9928 4.08883 9.99984 4.95962C10.0069 5.8304 9.78636 6.68792 9.36013 7.44729C8.93389 8.20667 8.31672 8.84155 7.56971 9.2891C6.8227 9.73666 5.97176 9.98136 5.10111 9.99898C4.23047 10.0166 3.37032 9.80653 2.60581 9.38957C1.8413 8.9726 1.19895 8.36321 0.742342 7.6217C0.285735 6.8802 0.030705 6.0323 0.00250009 5.16195L0 4.99995L0.00250009 4.83794C0.030502 3.97444 0.281777 3.13293 0.731829 2.39544C1.18188 1.65796 1.81535 1.04967 2.57048 0.629887C3.32561 0.210103 4.17662 -0.00685539 5.04057 0.000165123C5.90451 0.00718564 6.75189 0.237945 7.50009 0.669946ZM5.00006 1.99995C4.87759 1.99996 4.75939 2.04492 4.66787 2.1263C4.57635 2.20768 4.51788 2.31982 4.50356 2.44145L4.50006 2.49995V4.99995L4.50456 5.06544C4.51596 5.15219 4.54992 5.23443 4.60306 5.30395L4.64656 5.35395L6.14658 6.85394L6.19358 6.89494C6.28126 6.96298 6.38909 6.9999 6.50008 6.9999C6.61106 6.9999 6.7189 6.96298 6.80658 6.89494L6.85358 6.85344L6.89508 6.80644C6.96312 6.71876 7.00004 6.61093 7.00004 6.49995C7.00004 6.38896 6.96312 6.28113 6.89508 6.19345L6.85358 6.14645L5.50007 4.79245V2.49995L5.49657 2.44145C5.48224 2.31982 5.42377 2.20768 5.33225 2.1263C5.24073 2.04492 5.12253 1.99996 5.00006 1.99995Z"
            fill="white"
            fill-opacity="0.25"
          />
        </svg>
        <h3 className="text-white/40 text-sm font-normal">Extrato</h3>
      </div>

      {/* Table Container with Overflow */}
      <div className="flex-1 overflow-y-auto overflow-x-hidden scrollbar-hide">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead className="sticky top-0 bg-white/[.03] backdrop-blur-sm">
                Descrição
              </TableHead>
              <TableHead className="sticky top-0 bg-white/[.03] backdrop-blur-sm text-center">
                Valor
              </TableHead>
              <TableHead className="sticky top-0 bg-white/[.03] backdrop-blur-sm text-center">
                Tipo
              </TableHead>
              <TableHead className="sticky top-0 bg-white/[.03] backdrop-blur-sm text-center">
                Horário
              </TableHead>
              <TableHead className="sticky top-0 bg-white/[.03] backdrop-blur-sm text-center">
                Data
              </TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {loading ? (
              <TableRow>
                <TableCell colSpan={5} className="text-center py-8">
                  <div className="flex items-center justify-center gap-2">
                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                    <span className="text-white/60 text-sm">Carregando transações...</span>
                  </div>
                </TableCell>
              </TableRow>
            ) : formattedTransfers.length === 0 ? (
              <TableRow>
                <TableCell colSpan={5} className="text-center py-8">
                  <span className="text-white/60 text-sm">Nenhuma transação encontrada</span>
                </TableCell>
              </TableRow>
            ) : (
              formattedTransfers.map((transfer) => (
                <TableRow key={transfer.id}>
                  <TableCell>
                    <span className="font-medium truncate">
                      {transfer.description}
                    </span>
                  </TableCell>

                  <TableCell className="text-center">
                    <span
                      className={`font-semibold ${getValueColor(transfer.type)}`}
                    >
                      {getValuePrefix(transfer.type)}
                      {formatCurrency(Math.abs(transfer.value))}
                    </span>
                  </TableCell>

                  <TableCell className="text-center">
                    <div className="flex items-center justify-center gap-1">
                      {getTransferIcon(transfer.type)}
                      <span className="text-white/80 text-xs">
                        {getTransferTypeLabel(transfer.type)}
                      </span>
                    </div>
                  </TableCell>

                  <TableCell className="text-center">
                    <span className="text-white/60 text-xs">{transfer.time}</span>
                  </TableCell>

                  <TableCell className="text-center">
                    <span className="text-white/60 text-xs">{transfer.date}</span>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </div>
    </div>
  );
};

export default TransferHistory;
