import React, { useState } from "react";
import { AlertTriangle, User } from "lucide-react";
import { UserAvatar } from "@views/components/UserAvatar";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@views/components/ui/table";

interface Fine {
  id: string;
  description: string;
  value: number;
  applicant: string;
  type: "Multa";
  time: string;
  date: string;
  avatarUrl?: string;
}

interface FinesHistoryProps {
  className?: string;
}

const FinesHistory: React.FC<FinesHistoryProps> = ({ className }) => {
  const [fines, setFines] = useState<Fine[]>([
    {
      id: "1",
      description: "Estacionamento proibido",
      value: 10000,
      applicant: "Guilherme Costa",
      type: "Multa",
      time: "11:43",
      date: "24/09/2025",
    },
    {
      id: "2",
      description: "Xingar Oficial",
      value: 10000,
      applicant: "Guilherme Costa",
      type: "Multa",
      time: "11:43",
      date: "24/09/2025",
    },
    {
      id: "3",
      description: "Roubo",
      value: 10000,
      applicant: "Guilherme Costa",
      type: "Multa",
      time: "11:43",
      date: "24/09/2025",
    },
  ]);

  const [payingFines, setPayingFines] = useState<Set<string>>(new Set());

  const handlePayFine = async (fineId: string) => {
    setPayingFines((prev) => new Set(prev).add(fineId));

    try {
      await new Promise((resolve) => setTimeout(resolve, 2000));

      setFines((prevFines) => prevFines.filter((fine) => fine.id !== fineId));

      console.log(`Multa ${fineId} paga com sucesso`);
    } catch (error) {
      console.error("Erro ao pagar multa:", error);
    } finally {
      setPayingFines((prev) => {
        const newSet = new Set(prev);
        newSet.delete(fineId);
        return newSet;
      });
    }
  };

  const getFineIcon = () => {
    return (
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width=".875rem"
        height=".75rem"
        viewBox="0 0 14 12"
        fill="none"
      >
        <path
          d="M5.54877 0.611321C5.65109 0.425769 5.7996 0.271404 5.97914 0.163999C6.15867 0.056594 6.36279 0 6.57064 0C6.77848 0 6.9826 0.056594 7.16214 0.163999C7.34167 0.271404 7.49019 0.425769 7.59251 0.611321L12.9125 10.1706C13.3649 10.9839 12.7968 12 11.8893 12H1.25328C0.345813 12 -0.222326 10.9839 0.230105 10.1706L5.54877 0.611321ZM5.92059 4.66623V5.99964C5.92059 6.17646 5.98908 6.34604 6.11099 6.47107C6.23289 6.59611 6.39824 6.66635 6.57064 6.66635C6.74304 6.66635 6.90838 6.59611 7.03029 6.47107C7.1522 6.34604 7.22068 6.17646 7.22068 5.99964V4.66623C7.22068 4.48941 7.1522 4.31983 7.03029 4.1948C6.90838 4.06977 6.74304 3.99952 6.57064 3.99952C6.39824 3.99952 6.23289 4.06977 6.11099 4.1948C5.98908 4.31983 5.92059 4.48941 5.92059 4.66623ZM6.57064 7.66641C6.31204 7.66641 6.06402 7.77177 5.88116 7.95932C5.6983 8.14687 5.59557 8.40124 5.59557 8.66647C5.59557 8.9317 5.6983 9.18607 5.88116 9.37362C6.06402 9.56116 6.31204 9.66653 6.57064 9.66653C6.82924 9.66653 7.07725 9.56116 7.26012 9.37362C7.44298 9.18607 7.54571 8.9317 7.54571 8.66647C7.54571 8.40124 7.44298 8.14687 7.26012 7.95932C7.07725 7.77177 6.82924 7.66641 6.57064 7.66641Z"
          fill="#B35B5D"
        />
      </svg>
    );
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "USD",
    }).format(value);
  };

  const isPayingFine = (fineId: string) => payingFines.has(fineId);

  return (
    <div
      className={`flex flex-col rounded-md p-6 h-[20rem] ${className}`}
      style={{
        background:
          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
      }}
    >
      <div className="flex items-center gap-2 mb-4">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width=".75rem"
          height=".625rem"
          viewBox="0 0 12 10"
          fill="none"
        >
          <path
            d="M5.05614 0.509434C5.15058 0.354807 5.28767 0.22617 5.4534 0.136666C5.61913 0.0471617 5.80754 0 5.9994 0C6.19126 0 6.37967 0.0471617 6.5454 0.136666C6.71112 0.22617 6.84822 0.354807 6.94266 0.509434L11.8534 8.47546C12.271 9.15328 11.7466 10 10.9089 10H1.09106C0.253407 10 -0.271029 9.15328 0.1466 8.47546L5.05614 0.509434ZM5.39936 3.88852V4.9997C5.39936 5.14705 5.46258 5.28837 5.57511 5.39256C5.68764 5.49676 5.84026 5.55529 5.9994 5.55529C6.15854 5.55529 6.31116 5.49676 6.42369 5.39256C6.53622 5.28837 6.59944 5.14705 6.59944 4.9997V3.88852C6.59944 3.74117 6.53622 3.59986 6.42369 3.49566C6.31116 3.39147 6.15854 3.33294 5.9994 3.33294C5.84026 3.33294 5.68764 3.39147 5.57511 3.49566C5.46258 3.59986 5.39936 3.74117 5.39936 3.88852ZM5.9994 6.38867C5.76069 6.38867 5.53175 6.47648 5.36296 6.63277C5.19417 6.78906 5.09934 7.00103 5.09934 7.22206C5.09934 7.44308 5.19417 7.65506 5.36296 7.81135C5.53175 7.96764 5.76069 8.05544 5.9994 8.05544C6.23811 8.05544 6.46705 7.96764 6.63584 7.81135C6.80463 7.65506 6.89946 7.44308 6.89946 7.22206C6.89946 7.00103 6.80463 6.78906 6.63584 6.63277C6.46705 6.47648 6.23811 6.38867 5.9994 6.38867Z"
            fill="white"
            fill-opacity="0.25"
          />
        </svg>
        <h3 className="text-white/40 text-sm font-normal">Multas pendentes</h3>
      </div>

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
                Aplicador
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
              <TableHead className="sticky top-0 bg-white/[.03] backdrop-blur-sm text-center">
                Ação
              </TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {fines.map((fine) => (
              <TableRow key={fine.id}>
                <TableCell>
                  <span className="font-medium truncate">
                    {fine.description}
                  </span>
                </TableCell>

                <TableCell className="text-center">
                  <span className="font-semibold text-red-400">
                    {formatCurrency(fine.value).replace("US", "R")}
                  </span>
                </TableCell>

                <TableCell className="text-center">
                  <div className="flex items-center justify-center gap-1">
                    <UserAvatar size="sm" className="size-[1.25rem]" />
                    <span className="text-white/80 text-xs ml-[.75rem]">
                      {fine.applicant}
                    </span>
                  </div>
                </TableCell>

                <TableCell className="text-center">
                  <div className="flex items-center justify-center gap-1">
                    {getFineIcon()}
                    <span className="text-white/80 text-xs">{fine.type}</span>
                  </div>
                </TableCell>

                <TableCell className="text-center">
                  <span className="text-white/60 text-xs">{fine.time}</span>
                </TableCell>

                <TableCell className="text-center">
                  <span className="text-white/60 text-xs">{fine.date}</span>
                </TableCell>

                <TableCell className="text-center">
                  <button
                    onClick={() => handlePayFine(fine.id)}
                    disabled={isPayingFine(fine.id)}
                    className="px-4 py-1.5 bg-[#E74C3C] hover:bg-[#C0392B] disabled:opacity-50 disabled:cursor-not-allowed rounded text-white text-xs font-medium transition-all flex items-center justify-center gap-1 min-w-[4rem]"
                  >
                    {isPayingFine(fine.id) ? (
                      <div className="animate-spin rounded-full h-3 w-3 border-b-2 border-white"></div>
                    ) : (
                      "PAGAR"
                    )}
                  </button>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>
    </div>
  );
};

export default FinesHistory;
