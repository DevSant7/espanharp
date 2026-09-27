import React from "react";
import { formatCurrency as formatBRL } from "../../utils/formatCurrency";
import { FileText, User } from "lucide-react";
import { UserAvatar } from "@views/components/UserAvatar";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@views/components/ui/table";

interface Invoice {
  id: string;
  description: string;
  value: number;
  recipient: string;
  type: "Fatura";
  time: string;
  date: string;
  avatarUrl?: string;
}

interface InvoiceHistoryProps {
  className?: string;
  invoices?: any[];
  onRefresh?: () => void;
}

const InvoiceHistory: React.FC<InvoiceHistoryProps> = ({ className, invoices = [] }) => {

  const getInvoiceIcon = () => {
    return (
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width=".75rem"
        height=".75rem"
        viewBox="0 0 12 12"
        fill="none"
      >
        <path
          fill-rule="evenodd"
          clip-rule="evenodd"
          d="M0.5 12V2.66667C0.5 1.40933 0.5 0.781333 0.839263 0.390667C1.17853 -3.97364e-08 1.72389 0 2.81579 0H8.60526C9.08695 0 9.46095 -3.35276e-08 9.76547 0.018C9.1281 0.0993928 8.53919 0.44862 8.11148 0.998825C7.68377 1.54903 7.44731 2.26156 7.44737 3V5.33333L7.39005 11.978L5.71053 11.3333L3.97368 12L2.23684 11.3333L0.5 12ZM11.5 5.33333H8.60526V3C8.60526 2.55797 8.75775 2.13405 9.02919 1.82149C9.30062 1.50893 9.66877 1.33333 10.0526 1.33333C10.4365 1.33333 10.8046 1.50893 11.0761 1.82149C11.3475 2.13405 11.5 2.55797 11.5 3V5.33333ZM1.65789 2.66667C1.65789 2.48986 1.71889 2.32029 1.82746 2.19526C1.93604 2.07024 2.0833 2 2.23684 2H5.71053C5.86407 2 6.01133 2.07024 6.1199 2.19526C6.22848 2.32029 6.28947 2.48986 6.28947 2.66667C6.28947 2.84348 6.22848 3.01305 6.1199 3.13807C6.01133 3.2631 5.86407 3.33333 5.71053 3.33333H2.23684C2.0833 3.33333 1.93604 3.2631 1.82746 3.13807C1.71889 3.01305 1.65789 2.84348 1.65789 2.66667ZM1.65789 5.33333C1.65789 5.15652 1.71889 4.98695 1.82746 4.86193C1.93604 4.7369 2.0833 4.66667 2.23684 4.66667H3.39474C3.54828 4.66667 3.69554 4.7369 3.80411 4.86193C3.91269 4.98695 3.97368 5.15652 3.97368 5.33333C3.97368 5.51014 3.91269 5.67971 3.80411 5.80474C3.69554 5.92976 3.54828 6 3.39474 6H2.23684C2.0833 6 1.93604 5.92976 1.82746 5.80474C1.71889 5.67971 1.65789 5.51014 1.65789 5.33333ZM1.65789 8C1.65789 7.82319 1.71889 7.65362 1.82746 7.5286C1.93604 7.40357 2.0833 7.33333 2.23684 7.33333H4.55263C4.70618 7.33333 4.85344 7.40357 4.96201 7.5286C5.07058 7.65362 5.13158 7.82319 5.13158 8C5.13158 8.17681 5.07058 8.34638 4.96201 8.47141C4.85344 8.59643 4.70618 8.66667 4.55263 8.66667H2.23684C2.0833 8.66667 1.93604 8.59643 1.82746 8.47141C1.71889 8.34638 1.65789 8.17681 1.65789 8Z"
          fill="#B38A5B"
        />
      </svg>
    );
  };

  const formatCurrency = (value: number) => `$ ${formatBRL(value)}`;

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
            fillOpacity="0.25"
          />
        </svg>
        <h3 className="text-white/40 text-sm font-normal">
          Histórico de faturas
        </h3>
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
                Quem cobrou
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
            {invoices.map((invoice: any) => (
              <TableRow key={invoice.id}>
                <TableCell>
                  <span className="font-medium truncate">
                    {invoice.title || invoice.description}
                  </span>
                </TableCell>

                <TableCell className="text-center">
                  <span className="font-semibold text-orange-400">
                    {formatCurrency(invoice.amount || invoice.value)}
                  </span>
                </TableCell>

                <TableCell className="text-center">
                  <div className="flex items-center justify-center gap-1">
                    <UserAvatar size="sm" className="size-[1.25rem]" />
                    <span className="text-white/80 text-xs ml-[.75rem]">
                      {invoice.issuer_id || "-"}
                    </span>
                  </div>
                </TableCell>

                <TableCell className="text-center">
                  <div className="flex items-center justify-center gap-1">
                    {getInvoiceIcon()}
                    <span className="text-white/80 text-xs">
                      Fatura
                    </span>
                  </div>
                </TableCell>

                <TableCell className="text-center">
                  <span className="text-white/60 text-xs">{new Date(invoice.created_at || invoice.paid_at || Date.now()).toLocaleTimeString('pt-BR',{hour:'2-digit',minute:'2-digit'})}</span>
                </TableCell>

                <TableCell className="text-center">
                  <span className="text-white/60 text-xs">{new Date(invoice.created_at || invoice.paid_at || Date.now()).toLocaleDateString('pt-BR')}</span>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>
    </div>
  );
};

export default InvoiceHistory;
